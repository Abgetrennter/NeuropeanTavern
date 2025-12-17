import '../entity/xml_node.dart';

class StaticXmlParser {
  /// 解析 XML 字符串，返回节点列表
  /// 
  /// 遵循“容错解析”原则：
  /// 1. 遇到开始标签压栈
  /// 2. 遇到结束标签回溯查找匹配，自动闭合中间的标签
  /// 3. 忽略无效的结束标签
  static List<XmlNode> parse(String input) {
    final List<XmlNode> roots = [];
    // 栈用于追踪当前打开的标签
    final List<XmlElement> stack = [];

    // 辅助函数：将节点添加到当前上下文（栈顶元素或根列表）
    void addNode(XmlNode node) {
      if (stack.isEmpty) {
        roots.add(node);
      } else {
        stack.last.children.add(node);
      }
    }

    // 正则表达式匹配标签：
    // Group 1: 结束标签的斜杠 (/)
    // Group 2: 标签名
    // Group 3: 属性部分
    // Group 4: 自闭合标签的斜杠 (/)
    final tagRegex = RegExp(r'<(/)?([a-zA-Z0-9_\-]+)([^>]*?)(/?)>');
    
    int cursor = 0;

    for (final match in tagRegex.allMatches(input)) {
      // 1. 提取标签前的文本内容
      if (match.start > cursor) {
        final text = input.substring(cursor, match.start);
        if (text.isNotEmpty) {
          addNode(XmlText(text));
        }
      }

      // 2. 解析标签信息
      final isClosingSlash = match.group(1) == '/';
      final tagName = match.group(2)!;
      final attributesStr = match.group(3) ?? '';
      final isSelfClosing = match.group(4) == '/';

      if (isClosingSlash) {
        // 处理结束标签 </Tag>
        // 在栈中从上往下找匹配的标签
        int matchIndex = -1;
        for (int i = stack.length - 1; i >= 0; i--) {
          if (stack[i].tagName == tagName) {
            matchIndex = i;
            break;
          }
        }

        if (matchIndex != -1) {
          // 找到了匹配的开始标签
          // 将栈顶到该标签之间的所有元素弹出（视为自动闭合）
          while (stack.length > matchIndex) {
            stack.removeLast();
          }
        } else {
          // 未找到匹配，视为噪声，忽略该结束标签
          // (不做任何操作，相当于丢弃了这个标签)
        }
      } else {
        // 处理开始标签 <Tag ...>
        final attributes = _parseAttributes(attributesStr);
        
        // 创建新元素，注意 children 传入一个可变的空列表
        final newElement = XmlElement(
          tagName: tagName, 
          attributes: attributes, 
          children: [], 
        );

        addNode(newElement);

        // 如果不是自闭合标签，压入栈中
        if (!isSelfClosing) {
          stack.add(newElement);
        }
      }

      cursor = match.end;
    }

    // 3. 处理剩余的文本内容
    if (cursor < input.length) {
      final text = input.substring(cursor);
      addNode(XmlText(text));
    }

    return roots;
  }

  /// 简单的属性解析器
  static Map<String, String> _parseAttributes(String raw) {
    final attrs = <String, String>{};
    if (raw.trim().isEmpty) return attrs;

    // 匹配 key="value" 或 key='value'
    final attrRegex = RegExp(r'([a-zA-Z0-9_\-]+)\s*=\s*(["\x27])(.*?)\2');
    
    for (final match in attrRegex.allMatches(raw)) {
      final key = match.group(1)!;
      final value = match.group(3) ?? '';
      attrs[key] = value;
    }
    
    return attrs;
  }
}