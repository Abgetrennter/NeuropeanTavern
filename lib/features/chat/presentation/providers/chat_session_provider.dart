import 'package:flutter_riverpod/flutter_riverpod.dart';

// 简单的消息模型 (临时，后续会替换为 domain entity)
class ChatMessageModel {
  final String name;
  final String content;
  final bool isUser;
  final Map<String, dynamic>? metadata;

  ChatMessageModel({
    required this.name,
    required this.content,
    required this.isUser,
    this.metadata,
  });
}

class ChatSessionState {
  final List<ChatMessageModel> messages;
  final bool isGenerating;

  ChatSessionState({
    this.messages = const [],
    this.isGenerating = false,
  });

  ChatSessionState copyWith({
    List<ChatMessageModel>? messages,
    bool? isGenerating,
  }) {
    return ChatSessionState(
      messages: messages ?? this.messages,
      isGenerating: isGenerating ?? this.isGenerating,
    );
  }
}

class ChatSessionNotifier extends StateNotifier<ChatSessionState> {
  ChatSessionNotifier() : super(ChatSessionState(messages: [
    ChatMessageModel(
      isUser: false,
      name: 'AI Assistant',
      content: '你好！我是你的 AI 助手。有什么我可以帮你的吗？',
    ),
    ChatMessageModel(
      isUser: true,
      name: 'User',
      content: '你好，请给我讲一个关于猫娘的故事。',
    ),
    ChatMessageModel(
      isUser: false,
      name: 'AI Assistant',
      content: '当然可以！\n\n在一个遥远的魔法森林里，住着一只名叫“咪咪”的猫娘女仆。她不仅有着毛茸茸的耳朵和尾巴，还是一位编程高手...',
      metadata: {
        'status_type': 'native',
        'extension_id': 'character_status_v1',
      },
    ),
  ]));

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    // 添加用户消息
    final userMsg = ChatMessageModel(
      isUser: true,
      name: 'User',
      content: content,
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isGenerating: true,
    );

    // 模拟 AI 回复
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      
      final aiMsg = ChatMessageModel(
        isUser: false,
        name: 'AI Assistant',
        content: '这是一个模拟的回复喵~ (Powered by Riverpod)',
        metadata: {
          'status_type': 'web',
          'url': 'https://example.com/status_widget',
        },
      );

      state = state.copyWith(
        messages: [...state.messages, aiMsg],
        isGenerating: false,
      );
    });
  }
}

final chatSessionProvider = StateNotifierProvider<ChatSessionNotifier, ChatSessionState>((ref) {
  return ChatSessionNotifier();
});