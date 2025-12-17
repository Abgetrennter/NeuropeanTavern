//import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:neuropean/features/character/data/utils/character_card_parser.dart';

void main() {
  // A minimal valid PNG (1x1 pixel)
  final minimalPng = Uint8List.fromList([
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // Signature
    0x00, 0x00, 0x00, 0x0D, // IHDR length
    0x49, 0x48, 0x44, 0x52, // IHDR chunk type
    0x00, 0x00, 0x00, 0x01, // Width
    0x00, 0x00, 0x00, 0x01, // Height
    0x08, 0x06, 0x00, 0x00, 0x00, // Bit depth, color type, etc.
    0x1F, 0x15, 0xC4, 0x89, // CRC
    0x00, 0x00, 0x00, 0x0A, // IDAT length
    0x49, 0x44, 0x41, 0x54, // IDAT chunk type
    0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, // Data
    0x0D, 0x0A, 0x2D, 0xB4, // CRC
    0x00, 0x00, 0x00, 0x00, // IEND length
    0x49, 0x45, 0x4E, 0x44, // IEND chunk type
    0xAE, 0x42, 0x60, 0x82  // CRC
  ]);

  test('Should write and read character data from PNG', () {
    const testData = '{"name": "Test Character", "description": "A test"}';
    
    // Write data
    final newPng = CharacterCardParser.write(minimalPng, testData);
    
    // Read data back
    final readData = CharacterCardParser.read(newPng);
    
    // The parser adds V3 spec fields and prioritizes V3 chunk
    final expectedData = '{"name":"Test Character","description":"A test","spec":"chara_card_v3","spec_version":"3.0"}';
    expect(readData, equals(expectedData));
  });

  test('Should throw exception if no metadata found', () {
    expect(() => CharacterCardParser.read(minimalPng), throwsException);
  });
  
  test('Should overwrite existing chara chunk', () {
     const data1 = '{"name": "Char 1"}';
     const data2 = '{"name": "Char 2"}';
     
     var png = CharacterCardParser.write(minimalPng, data1);
     // Expect V3 format
     expect(CharacterCardParser.read(png), contains('"name":"Char 1"'));
     expect(CharacterCardParser.read(png), contains('"spec":"chara_card_v3"'));
     
     png = CharacterCardParser.write(png, data2);
     expect(CharacterCardParser.read(png), contains('"name":"Char 2"'));
     expect(CharacterCardParser.read(png), contains('"spec":"chara_card_v3"'));
  });
}