import 'dart:async';
import '../entities/chat_message.dart';
import 'orchestrator_interface.dart';

class MockOrchestrator implements OrchestratorInterface {
  final List<ChatMessage> _chatHistory = [];
  
  @override
  Stream<String> processUserMessage(String input) async* {
    // Add user message to history
    _chatHistory.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: input,
      role: 'user',
      timestamp: DateTime.now(),
    ));
    
    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock response
    final response = '这是对"$input"的模拟回复。在实际实现中，这里会调用LLM API。';
    
    // Add assistant message to history
    _chatHistory.add(ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: response,
      role: 'assistant',
      timestamp: DateTime.now(),
    ));
    
    // Yield response in chunks to simulate streaming
    final words = response.split(' ');
    for (int i = 0; i < words.length; i++) {
      yield words[i] + (i < words.length - 1 ? ' ' : '');
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
  
  @override
  List<ChatMessage> getChatHistory() {
    return List.unmodifiable(_chatHistory);
  }
  
  @override
  Future<void> clearChatHistory() async {
    _chatHistory.clear();
  }
}