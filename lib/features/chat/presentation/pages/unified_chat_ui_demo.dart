import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/adaptive_scaffold.dart';
import '../../../../core/presentation/widgets/atomic/atom_button.dart';
import '../../../../core/presentation/widgets/atomic/atom_input.dart';
import '../../../../core/presentation/widgets/atomic/atom_avatar.dart';

class UnifiedChatUIDemo extends StatefulWidget {
  const UnifiedChatUIDemo({super.key});

  @override
  State<UnifiedChatUIDemo> createState() => _UnifiedChatUIDemoState();
}

class _UnifiedChatUIDemoState extends State<UnifiedChatUIDemo> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isGenerating = false;

  // 模拟消息数据
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'name': 'AI Assistant',
      'content': '你好！我是你的 AI 助手。有什么我可以帮你的吗？',
    },
    {
      'isUser': true,
      'name': 'User',
      'content': '你好，请给我讲一个关于猫娘的故事。',
    },
    {
      'isUser': false,
      'name': 'AI Assistant',
      'content': '当然可以！\n\n在一个遥远的魔法森林里，住着一只名叫“咪咪”的猫娘女仆。她不仅有着毛茸茸的耳朵和尾巴，还是一位编程高手...',
    },
  ];

  void _showStatusPanel(BuildContext context, ColorScheme colorScheme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Relationship Status',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildStatusItem(
                context,
                colorScheme,
                icon: Icons.favorite_rounded,
                label: 'Affection',
                value: 0.85,
                color: Colors.pinkAccent,
              ),
              const SizedBox(height: 16),
              _buildStatusItem(
                context,
                colorScheme,
                icon: Icons.verified_user_rounded,
                label: 'Trust',
                value: 0.60,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 16),
              _buildStatusItem(
                context,
                colorScheme,
                icon: Icons.mood_rounded,
                label: 'Mood',
                value: 0.92,
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 16),
              _buildStatusItem(
                context,
                colorScheme,
                icon: Icons.battery_charging_full_rounded,
                label: 'Energy',
                value: 0.45,
                color: Colors.greenAccent,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusItem(
    BuildContext context,
    ColorScheme colorScheme, {
    required IconData icon,
    required String label,
    required double value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${(value * 100).toInt()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  color: color,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'isUser': true,
        'name': 'User',
        'content': _textController.text,
      });
      _textController.clear();
      _isGenerating = true;
    });

    // 滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // 模拟 AI 回复
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _messages.add({
            'isUser': false,
            'name': 'AI Assistant',
            'content': '这是一个模拟的回复喵~',
          });
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用亮色主题和清柔的 ColorScheme
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFB0C4DE), // LightSteelBlue，清柔的蓝灰色
      brightness: Brightness.light,
    );

    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface, // 使用 surface 作为背景
      ),
      child: DefaultTabController(
        length: 3,
        child: AdaptiveScaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.surface,
            title: Text(
              'Unified Chat UI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: colorScheme.onSurfaceVariant,
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              labelColor: colorScheme.primary,
              unselectedLabelColor: colorScheme.onSurfaceVariant,
              indicatorColor: colorScheme.primary,
              tabs: const [
                Tab(text: 'Chat'),
                Tab(text: 'Memory'),
                Tab(text: 'Settings'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Chat Tab
              Column(
                children: [
                  // 中部消息区域
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final msg = _messages[index];
                            return _buildMessageBubble(
                              context,
                              colorScheme,
                              isUser: msg['isUser'],
                              name: msg['name'],
                              content: msg['content'],
                            );
                          },
                        ),
                        
                        // 生成中状态
                        if (_isGenerating)
                          Positioned(
                            top: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  // 尝试使用 surfaceContainerHigh，如果不可用则使用 surfaceVariant
                                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "AI 正在生成…",
                                      style: TextStyle(
                                        color: colorScheme.onSurfaceVariant,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // 底部输入区域，使用原子化组件重构
                  _buildInputArea(colorScheme),
                ],
              ),
              
              // Memory Tab (Placeholder)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.memory, size: 64, color: colorScheme.primary.withValues(alpha: 0.5)),
                    const SizedBox(height: 16),
                    Text(
                      'Memory Management',
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Settings Tab (Placeholder)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, size: 64, color: colorScheme.primary.withValues(alpha: 0.5)),
                    const SizedBox(height: 16),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ColorScheme colorScheme, {
    required bool isUser,
    required String name,
    required String content,
  }) {
    // 这里可以使用 AtomAvatar，但布局上还是保持 M3 的设计
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser
              ? colorScheme.primaryContainer.withValues(alpha: 0.8)
              // 尝试使用 surfaceContainerLow，如果不可用则使用 surfaceVariant
              : colorScheme.secondaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isUser) ...[
               AtomAvatar(
                size: AtomAvatarSize.small,
                status: OnlineStatus.online,
                fallbackText: name[0],
                backgroundColor: colorScheme.primary.withValues(alpha: 0.2),
                textColor: colorScheme.primary,
              ),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      color: isUser
                          ? colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: isUser
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            if (isUser) ...[
              const SizedBox(width: 12),
              AtomAvatar(
                size: AtomAvatarSize.small,
                status: OnlineStatus.online,
                fallbackText: name[0],
                 backgroundColor: colorScheme.primary,
                 textColor: colorScheme.onPrimary,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        // 尝试使用 surfaceContainerHigh，如果不可用则使用 surface
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Column(
        children: [
          // 状态按钮行
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: colorScheme.onSurfaceVariant,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.image_outlined),
                color: colorScheme.onSurfaceVariant,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                color: colorScheme.primary,
                onPressed: () => _showStatusPanel(context, colorScheme),
                tooltip: 'Show Status',
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          // 输入行，使用 AtomInput 和 AtomButton
          Row(
            children: [
              Expanded(
                child: AtomInput(
                  controller: _textController,
                  hintText: 'Type a message...',
                  prefixIcon: null, // M3 design doesn't have prefix here
                ),
              ),
              const SizedBox(width: 12),
              AtomButton(
                label: '', // Only icon for send button in this layout
                icon: Icons.send,
                onPressed: _sendMessage,
                // Customize AtomButton to match M3 style if needed, 
                // or rely on its default which might be slightly different.
                // Here we might need to adjust AtomButton to support icon-only better or just use it as is if it supports it.
                // Assuming AtomButton can handle empty label or we might want to use a specific IconButton if AtomButton is strictly labeled.
                // For now, let's assume we want the button look.
              ),
            ],
          ),
        ],
      ),
    );
  }
}
