abstract class XmlStreamEvent {
  const XmlStreamEvent();
}

class XmlTagOpenEvent extends XmlStreamEvent {
  final String tagName;
  final Map<String, String> attributes;

  const XmlTagOpenEvent(this.tagName, {this.attributes = const {}});

  @override
  String toString() => 'Open<$tagName>';
}

class XmlTagCloseEvent extends XmlStreamEvent {
  final String tagName;

  const XmlTagCloseEvent(this.tagName);

  @override
  String toString() => 'Close</$tagName>';
}

class XmlContentEvent extends XmlStreamEvent {
  final String text;
  final String parentTag;

  const XmlContentEvent(this.text, {required this.parentTag});

  @override
  String toString() => 'Content("$text") in <$parentTag>';
}