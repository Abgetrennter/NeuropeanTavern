import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/adaptive_scaffold.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../domain/entities/chat_message.dart';
import '../providers/chat_provider.dart';
import '../widgets/input_control_deck.dart';
import '../widgets/message/message_bubble.dart';
import '../widgets/message/swipeable_message.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSendMessage(Future<void> Function(String) sendMessage) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isLoading = true);
    _controller.clear();
    
    try {
      await sendMessage(text);
      // 滚动到底部
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final sendMessage = ref.watch(sendMessageProvider);

    return AdaptiveScaffold(
      backgroundColor: DesignTokens.pageBackgroundColor,
      appBar: AppBar(
        title: const Text('NEuropean Chat'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacingMd,
                vertical: DesignTokens.spacingMd,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageItem(message);
              },
            ),
          ),
          InputControlDeck(
            textController: _controller,
            onSendMessage: () => _handleSendMessage(sendMessage),
            onShowStatus: () {}, // TODO: Implement status panel
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    final isUser = message.role == 'user';
    
    return SwipeableMessage(
      enabled: true,
      onSwipeLeft: (_) {
        // TODO: Handle edit action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit message')),
        );
      },
      onSwipeRight: (_) {
        // TODO: Handle reply action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reply to message')),
        );
      },
      child: MessageBubble(
        content: message.content,
        isUser: isUser,
        senderName: isUser ? 'User' : 'Assistant',
        status: MessageStatus.sent, // TODO: Bind real status
      ),
    );
  }
}
