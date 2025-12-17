import 'dart:async';
import '../entity/xml_stream_event.dart';

class StreamXmlParser {
  final _controller = StreamController<XmlStreamEvent>();
  Stream<XmlStreamEvent> get stream => _controller.stream;

  String _buffer = '';
  final List<String> _stack = [];
  
  // 正则表达式匹配标签：
  // Group 1: 结束标签的斜杠 (/)
  // Group 2: 标签名
  // Group 3: 属性部分
  // Group 4: 自闭合标签的斜杠 (/)
  final _tagRegex = RegExp(r'<(/)?([a-zA-Z0-9_\-]+)([^>]*?)(/?)>');

  /// 处理新的文本片段
  void feed(String chunk) {
    _buffer += chunk;
    _processBuffer();
  }

  /// 结束流，处理剩余内容并强制闭合标签
  void close() {
    // 处理剩余的文本
    if (_buffer.isNotEmpty) {
      // 如果 buffer 里还有东西，但不是标签（或者是不完整的标签），
      // 在流结束时，我们只能把它当做文本处理了
      if (_stack.isNotEmpty) {
        _controller.add(XmlContentEvent(_buffer, parentTag: _stack.last));
      }
      _buffer = '';
    }

    // 强制闭合所有剩余标签
    while (_stack.isNotEmpty) {
      final tag = _stack.removeLast();
      _controller.add(XmlTagCloseEvent(tag));
    }

    _controller.close();
  }

  void _processBuffer() {
    int cursor = 0;
    
    // 查找所有完整的标签
    for (final match in _tagRegex.allMatches(_buffer)) {
      // 1. 处理标签前的文本内容
      if (match.start > cursor) {
        final text = _buffer.substring(cursor, match.start);
        if (text.isNotEmpty && _stack.isNotEmpty) {
          _controller.add(XmlContentEvent(text, parentTag: _stack.last));
        }
      }

      // 2. 解析标签信息
      final isClosingSlash = match.group(1) == '/';
      final tagName = match.group(2)!;
      final attributesStr = match.group(3) ?? '';
      final isSelfClosing = match.group(4) == '/';

      if (isClosingSlash) {
        // 处理结束标签 </Tag>
        _handleCloseTag(tagName);
      } else {
        // 处理开始标签 <Tag ...>
        final attributes = _parseAttributes(attributesStr);
        
        _controller.add(XmlTagOpenEvent(tagName, attributes: attributes));

        if (!isSelfClosing) {
          _stack.add(tagName);
        } else {
          // 自闭合标签，立即发送关闭事件
          _controller.add(XmlTagCloseEvent(tagName));
        }
      }

      cursor = match.end;
    }

    // 3. 处理剩余 Buffer (关键：流式体验)
    // 我们需要保留可能是半个标签的内容
    // 策略：保留最后一个 '<' 之后的内容，如果它看起来像是一个未完成的标签
    
    final remaining = _buffer.substring(cursor);
    final lastOpenAngle = remaining.lastIndexOf('<');

    if (lastOpenAngle != -1) {
      // 如果有 '<'，说明可能是半个标签
      // 先把 '<' 之前的内容作为文本发射出去
      if (lastOpenAngle > 0) {
        final safeText = remaining.substring(0, lastOpenAngle);
        if (safeText.isNotEmpty && _stack.isNotEmpty) {
          _controller.add(XmlContentEvent(safeText, parentTag: _stack.last));
        }
      }
      // 保留 '<' 及之后的内容到下一次处理
      _buffer = remaining.substring(lastOpenAngle);
    } else {
      // 如果没有 '<'，说明全是安全的文本
      if (remaining.isNotEmpty && _stack.isNotEmpty) {
        _controller.add(XmlContentEvent(remaining, parentTag: _stack.last));
      }
      _buffer = ''; // 清空 buffer
    }
  }

  void _handleCloseTag(String tagName) {
    // 逆向搜索匹配的标签
    int matchIndex = -1;
    for (int i = _stack.length - 1; i >= 0; i--) {
      if (_stack[i] == tagName) {
        matchIndex = i;
        break;
      }
    }

    if (matchIndex != -1) {
      // 找到了匹配的开始标签
      // 将栈顶到该标签之间的所有元素弹出（视为自动闭合）
      while (_stack.length > matchIndex) {
        final poppedTag = _stack.removeLast();
        _controller.add(XmlTagCloseEvent(poppedTag));
      }
    } else {
      // 未找到匹配，忽略该结束标签
    }
  }

  /// 简单的属性解析器
  static Map<String, String> _parseAttributes(String raw) {
    final attrs = <String, String>{};
    if (raw.trim().isEmpty) return attrs;

    final attrRegex = RegExp(r'([a-zA-Z0-9_\-]+)\s*=\s*(["\x27])(.*?)\2');
    
    for (final match in attrRegex.allMatches(raw)) {
      final key = match.group(1)!;
      final value = match.group(3) ?? '';
      attrs[key] = value;
    }
    
    return attrs;
  }
}