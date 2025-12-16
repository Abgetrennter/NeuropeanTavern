import 'dart:convert';
import 'dart:typed_data';

class CharacterCardParser {
  /// Reads Character metadata from a PNG image buffer.
  /// Supports both V2 (chara) and V3 (ccv3). V3 (ccv3) takes precedence.
  static String read(Uint8List image) {
    final chunks = _extractChunks(image);

    final textChunks = chunks
        .where((chunk) => chunk.name == 'tEXt')
        .map((chunk) => _decodePngText(chunk.data))
        .toList();

    if (textChunks.isEmpty) {
      throw Exception('No PNG metadata.');
    }

    // Check for ccv3
    try {
      final ccv3Chunk = textChunks.firstWhere(
        (chunk) => chunk.keyword.toLowerCase() == 'ccv3',
      );
      return utf8.decode(base64.decode(ccv3Chunk.text));
    } catch (e) {
      // Ignore if not found
    }

    // Check for chara
    try {
      final charaChunk = textChunks.firstWhere(
        (chunk) => chunk.keyword.toLowerCase() == 'chara',
      );
      return utf8.decode(base64.decode(charaChunk.text));
    } catch (e) {
      // Ignore if not found
    }

    throw Exception('No PNG metadata.');
  }

  /// Writes Character metadata to a PNG image buffer.
  /// Writes only 'chara', 'ccv3' is not supported and removed not to create a mismatch.
  static Uint8List write(Uint8List image, String data) {
    final chunks = _extractChunks(image);

    // Remove existing tEXt chunks with 'chara' or 'ccv3'
    chunks.removeWhere((chunk) {
      if (chunk.name != 'tEXt') return false;
      try {
        final decoded = _decodePngText(chunk.data);
        final keyword = decoded.keyword.toLowerCase();
        return keyword == 'chara' || keyword == 'ccv3';
      } catch (e) {
        return false;
      }
    });

    // Add new v2 chunk before the IEND chunk
    final base64EncodedData = base64.encode(utf8.encode(data));
    final newChunkData = _encodePngText('chara', base64EncodedData);
    
    // Find IEND chunk index
    final iendIndex = chunks.lastIndexWhere((chunk) => chunk.name == 'IEND');
    if (iendIndex != -1) {
      chunks.insert(iendIndex, _PngChunk(name: 'tEXt', data: newChunkData));
    } else {
      chunks.add(_PngChunk(name: 'tEXt', data: newChunkData));
    }

    // Try adding v3 chunk (optional, based on original logic)
    try {
      final v3Data = jsonDecode(data) as Map<String, dynamic>;
      v3Data['spec'] = 'chara_card_v3';
      v3Data['spec_version'] = '3.0';
      
      final v3Base64EncodedData = base64.encode(utf8.encode(jsonEncode(v3Data)));
      final v3ChunkData = _encodePngText('ccv3', v3Base64EncodedData);
      
      if (iendIndex != -1) {
         // Insert before IEND, but after the chara chunk we just inserted (which is now at iendIndex)
         chunks.insert(iendIndex + 1, _PngChunk(name: 'tEXt', data: v3ChunkData));
      } else {
        chunks.add(_PngChunk(name: 'tEXt', data: v3ChunkData));
      }

    } catch (e) {
      // Ignore errors when adding v3 chunk
    }

    return _encodeChunks(chunks);
  }

  static List<_PngChunk> _extractChunks(Uint8List data) {
    final chunks = <_PngChunk>[];
    var offset = 8; // Skip PNG signature

    while (offset < data.length) {
      final length = _readUint32(data, offset);
      final name = String.fromCharCodes(data.sublist(offset + 4, offset + 8));
      final chunkData = data.sublist(offset + 8, offset + 8 + length);
      // CRC is 4 bytes after data
      
      chunks.add(_PngChunk(name: name, data: chunkData));
      offset += 12 + length;
    }

    return chunks;
  }

  static Uint8List _encodeChunks(List<_PngChunk> chunks) {
    final buffer = BytesBuilder();
    buffer.add([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]); // PNG signature

    for (final chunk in chunks) {
      final length = chunk.data.length;
      final lengthBytes = ByteData(4)..setUint32(0, length);
      buffer.add(lengthBytes.buffer.asUint8List());
      
      final nameBytes = chunk.name.codeUnits;
      buffer.add(nameBytes);
      
      buffer.add(chunk.data);
      
      final crc = _crc32([...nameBytes, ...chunk.data]);
      final crcBytes = ByteData(4)..setUint32(0, crc);
      buffer.add(crcBytes.buffer.asUint8List());
    }

    return buffer.toBytes();
  }

  static int _readUint32(Uint8List data, int offset) {
    return ByteData.sublistView(data, offset, offset + 4).getUint32(0);
  }

  static _PngText _decodePngText(Uint8List data) {
    int separatorIndex = -1;
    for (int i = 0; i < data.length; i++) {
      if (data[i] == 0) {
        separatorIndex = i;
        break;
      }
    }

    if (separatorIndex == -1) {
      throw Exception('Invalid tEXt chunk data');
    }

    final keyword = String.fromCharCodes(data.sublist(0, separatorIndex));
    final text = String.fromCharCodes(data.sublist(separatorIndex + 1));

    return _PngText(keyword: keyword, text: text);
  }

  static Uint8List _encodePngText(String keyword, String text) {
    final keywordBytes = utf8.encode(keyword);
    final textBytes = utf8.encode(text);
    final buffer = BytesBuilder();
    buffer.add(keywordBytes);
    buffer.addByte(0);
    buffer.add(textBytes);
    return buffer.toBytes();
  }

  // CRC32 implementation
  static final List<int> _crcTable = _makeCrcTable();

  static List<int> _makeCrcTable() {
    final table = List<int>.filled(256, 0);
    for (int n = 0; n < 256; n++) {
      int c = n;
      for (int k = 0; k < 8; k++) {
        if ((c & 1) != 0) {
          c = 0xedb88320 ^ (c >> 1);
        } else {
          c = c >> 1;
        }
      }
      table[n] = c;
    }
    return table;
  }

  static int _crc32(List<int> buf) {
    int crc = 0xffffffff;
    for (int i = 0; i < buf.length; i++) {
      crc = _crcTable[(crc ^ buf[i]) & 0xff] ^ (crc >> 8);
    }
    return crc ^ 0xffffffff;
  }
}

class _PngChunk {
  final String name;
  final Uint8List data;

  _PngChunk({required this.name, required this.data});
}

class _PngText {
  final String keyword;
  final String text;

  _PngText({required this.keyword, required this.text});
}