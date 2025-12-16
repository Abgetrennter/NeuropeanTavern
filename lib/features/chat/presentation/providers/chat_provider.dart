import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/chat_message.dart';

// Mock data for demonstration
final List<ChatMessage> _mockMessages = [
  ChatMessage(
    id: const Uuid().v4(),
    content: '你好！我是你的AI助手，有什么可以帮助你的吗？',
    role: 'assistant',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  ChatMessage(
    id: const Uuid().v4(),
    content: '请介绍一下NEuropean项目',
    role: 'user',
    timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
  ),
  ChatMessage(
    id: const Uuid().v4(),
    content: 'NEuropean是一个基于Flutter开发的AI角色扮演聊天应用。它采用了Clean Architecture架构，使用Riverpod进行状态管理，支持角色卡导入、动态交互和状态管理等功能。',
    role: 'assistant',
    timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
  ),
];

// Provider for the chat messages list
final chatMessagesProvider = StateProvider<List<ChatMessage>>((ref) {
  return _mockMessages;
});

// Provider for the send message function
final sendMessageProvider = Provider<Future<void> Function(String)>((ref) {
  return (String message) async {
    // Add user message
    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: message,
      role: 'user',
      timestamp: DateTime.now(),
    );
    
    ref.read(chatMessagesProvider.notifier).state = [
      ...ref.read(chatMessagesProvider.notifier).state,
      userMessage,
    ];
    
    // Simulate AI response
    await Future.delayed(const Duration(seconds: 1));
    
    final aiMessage = ChatMessage(
      id: const Uuid().v4(),
      content: '这是对"$message"的模拟回复。在实际应用中，这里会调用LLM API生成回复。',
      role: 'assistant',
      timestamp: DateTime.now(),
    );
    
    ref.read(chatMessagesProvider.notifier).state = [
      ...ref.read(chatMessagesProvider.notifier).state,
      aiMessage,
    ];
  };
});