import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/adaptive_scaffold.dart';
import '../providers/chat_session_provider.dart';
import '../providers/input_draft_provider.dart';
import '../widgets/chat_message_item.dart';
import '../widgets/input_control_deck.dart';
import '../widgets/status_inspector_panel.dart';

class AtomizedChatUIDemo extends ConsumerStatefulWidget {
  const AtomizedChatUIDemo({super.key});

  @override
  ConsumerState<AtomizedChatUIDemo> createState() => _AtomizedChatUIDemoState();
}

class _AtomizedChatUIDemoState extends ConsumerState<AtomizedChatUIDemo> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0; // For NavigationRail

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    ref.read(inputDraftProvider.notifier).updateText(_textController.text);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showStatusPanel(BuildContext context, ColorScheme colorScheme) {
    // 在移动端显示 BottomSheet，在桌面端不需要（因为有右侧栏）
    if (AdaptiveScaffold.getScreenType(context) == ScreenType.mobile) {
      showModalBottomSheet(
        context: context,
        backgroundColor: colorScheme.surface,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (context) {
          return StatusInspectorPanel(colorScheme: colorScheme);
        },
      );
    } else {
      // 桌面端/平板端逻辑：可能切换右侧栏可见性，这里暂不处理，因为右侧栏常驻
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status panel is already visible on the right.')),
      );
    }
  }

  void _sendMessage() {
    final content = _textController.text;
    if (content.trim().isEmpty) return;

    ref.read(chatSessionProvider.notifier).sendMessage(content);
    ref.read(inputDraftProvider.notifier).clear();
    _textController.clear();

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
  }

  @override
  Widget build(BuildContext context) {
    // 监听外部对草稿的修改（例如点击快捷指令）
    ref.listen(inputDraftProvider, (previous, next) {
      if (next.text != _textController.text) {
        _textController.text = next.text;
        _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: next.text.length),
        );
      }
    });

    final chatState = ref.watch(chatSessionProvider);
    final messages = chatState.messages;
    final isGenerating = chatState.isGenerating;
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
      child: AdaptiveScaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          title: Text(
            'Chat Session (Responsive)',
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
        ),
        // 左侧导航栏 (Tablet/Desktop)
        navigationRail: NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: Text('Chat'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.memory),
              selectedIcon: Icon(Icons.memory_outlined),
              label: Text('Memory'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        // 底部导航栏 (Mobile)
        bottomNavigation: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.memory),
              selectedIcon: Icon(Icons.memory_outlined),
              label: 'Memory',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        // 右侧面板 (Desktop)
        secondaryBody: Container(
          color: colorScheme.surfaceContainerLow,
          child: StatusInspectorPanel(colorScheme: colorScheme),
        ),
        // 主体内容
        body: IndexedStack(
          index: _selectedIndex,
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
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          return ChatMessageItem(
                            name: msg.name,
                            content: msg.content,
                            isUser: msg.isUser,
                            colorScheme: colorScheme,
                          );
                        },
                      ),
                      
                      // 生成中状态
                      if (isGenerating)
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

                // 底部输入区域
                InputControlDeck(
                  textController: _textController,
                  onSendMessage: _sendMessage,
                  onShowStatus: () => _showStatusPanel(context, colorScheme),
                  colorScheme: colorScheme,
                ),
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
    );
  }
}