abstract class XmlNode {
  const XmlNode();
}

class XmlElement extends XmlNode {
  final String tagName;
  final Map<String, String> attributes;
  final List<XmlNode> children;

  const XmlElement({
    required this.tagName,
    this.attributes = const {},
    this.children = const [],
  });

  @override
  String toString() {
    final childrenStr = children.map((e) => e.toString()).join(', ');
    final attrsStr = attributes.entries.map((e) => '${e.key}="${e.value}"').join(' ');
    final tagInfo = attrsStr.isEmpty ? tagName : '$tagName $attrsStr';
    return 'XmlElement($tagInfo, children: [$childrenStr])';
  }
}

class XmlText extends XmlNode {
  final String text;

  const XmlText(this.text);

  @override
  String toString() {
    return 'XmlText(text: "${text.replaceAll('\n', '\\n')}")';
  }
}