class ChatMessage {
  final String id;
  final String content;
  final String role; // 'user', 'assistant', 'system'
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
  });
}