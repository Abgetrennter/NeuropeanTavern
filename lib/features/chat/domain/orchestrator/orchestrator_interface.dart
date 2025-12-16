import 'dart:async';
import '../entities/chat_message.dart';

abstract class OrchestratorInterface {
  /// Processes a user message and returns a stream of response chunks
  Stream<String> processUserMessage(String input);
  
  /// Gets the current chat history
  List<ChatMessage> getChatHistory();
  
  /// Clears the chat history
  Future<void> clearChatHistory();
}