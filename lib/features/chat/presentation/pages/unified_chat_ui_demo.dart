import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/adaptive_scaffold.dart';
import '../../../../core/presentation/widgets/atomic/atom_button.dart';
import '../../../../core/presentation/widgets/atomic/atom_input.dart';
import '../../../../core/presentation/widgets/atomic/atom_avatar.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/theme_state.dart';
import '../widgets/decision_card/decision_card_widget.dart';

class UnifiedChatUIDemo extends ConsumerStatefulWidget {
  const UnifiedChatUIDemo({super.key});

  @override
  ConsumerState<UnifiedChatUIDemo> createState() => _UnifiedChatUIDemoState();
}

class _UnifiedChatUIDemoState extends ConsumerState<UnifiedChatUIDemo> {
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

  void _showDecisionCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // 透明背景以显示卡片的异形效果
      isScrollControlled: true, // 允许自适应高度
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DecisionCard(
                title: '剧情抉择',
                subtitle: 'Chapter 3 · The Crossroads',
                options: const [
                  '立刻出发前往魔法森林深处寻找线索',
                  '先回到城镇休整，打听更多关于“暗影”的情报',
                  '在这个废弃的营地过夜，观察周围的动静',
                ],
                tipsText: '不同的选择将导向完全不同的剧情分支。请慎重考虑当前的队伍状态（Energy: 45%）和剩余的补给品。',
                confirmButtonText: '确定选择',
                onOptionTap: (index, isSelected) {
                  // 这里可以添加选中时的逻辑
                },
                onConfirm: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('已做出选择，剧情继续...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
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
    final themeState = ref.watch(themeProvider);
    // 使用当前主题的 ColorScheme
    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context), // 直接使用上下文中的主题，它应该已经是通过 ThemeProvider 配置的
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
              
              // Settings Tab
              _buildSettingsTab(colorScheme, themeState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTab(ColorScheme colorScheme, ThemeState themeState) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionHeader('Theme Mode', colorScheme),
        const SizedBox(height: 16),
        SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(
              value: ThemeMode.system,
              label: Text('System'),
              icon: Icon(Icons.brightness_auto),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              label: Text('Light'),
              icon: Icon(Icons.brightness_5),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text('Dark'),
              icon: Icon(Icons.brightness_2),
            ),
          ],
          selected: {themeState.themeMode},
          onSelectionChanged: (Set<ThemeMode> newSelection) {
            ref.read(themeProvider.notifier).updateThemeMode(newSelection.first);
          },
        ),

        const SizedBox(height: 32),
        _buildSectionHeader('Seed Color', colorScheme),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildColorOption(DesignTokens.primaryColor, themeState.seedColor),
            _buildColorOption(Colors.blue, themeState.seedColor),
            _buildColorOption(Colors.green, themeState.seedColor),
            _buildColorOption(Colors.purple, themeState.seedColor),
            _buildColorOption(Colors.red, themeState.seedColor),
            _buildColorOption(Colors.teal, themeState.seedColor),
            _buildColorOption(Colors.pink, themeState.seedColor),
            _buildColorOption(Colors.indigo, themeState.seedColor),
          ],
        ),
        if (themeState.seedColor != DesignTokens.primaryColor)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  ref.read(themeProvider.notifier).resetSeedColor();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset to Default'),
              ),
            ),
          ),

        const SizedBox(height: 32),
        _buildSectionHeader('Font Family', colorScheme),
        Column(
          children: [
            RadioListTile<String?>(
              title: const Text('Default (Noto Sans)'),
              value: null,
              groupValue: themeState.fontFamily,
              onChanged: (value) {
                ref.read(themeProvider.notifier).updateFontFamily(null);
              },
            ),
            RadioListTile<String?>(
              title: const Text('Monospace'),
              value: 'Noto Sans Mono',
              groupValue: themeState.fontFamily,
              onChanged: (value) {
                ref.read(themeProvider.notifier).updateFontFamily(value);
              },
            ),
          ],
        ),

        const SizedBox(height: 32),
        _buildSectionHeader('Corner Radius', colorScheme),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.rounded_corner, size: 20),
            Expanded(
              child: Slider(
                value: themeState.customBorderRadius,
                min: 0.0,
                max: 2.0,
                divisions: 20,
                label: themeState.customBorderRadius.toStringAsFixed(1),
                onChanged: (value) {
                  ref.read(themeProvider.notifier).updateCustomBorderRadius(value);
                },
              ),
            ),
            Text(
              '${themeState.customBorderRadius.toStringAsFixed(1)}x',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
    );
  }

  Widget _buildColorOption(Color color, Color selectedColor) {
    final isSelected = color.value == selectedColor.value;
    return GestureDetector(
      onTap: () {
        ref.read(themeProvider.notifier).updateSeedColor(color);
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.onSurface : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              )
            : null,
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
              IconButton(
                icon: const Icon(Icons.extension),
                color: colorScheme.primary,
                onPressed: () => _showDecisionCard(context),
                tooltip: 'Show Decision Card',
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
