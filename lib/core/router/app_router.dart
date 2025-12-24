import 'package:go_router/go_router.dart';
import '../../features/character/presentation/pages/test_panel_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/atomized_chat_ui_demo.dart';
import '../../features/chat/presentation/pages/material3_chat_ui_demo.dart';
import '../../features/chat/presentation/pages/unified_chat_ui_demo.dart';
import '../../features/debug/presentation/pages/debug_menu_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DebugMenuPage(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => const TestPanelPage(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: '/demo',
      builder: (context, state) => const AtomizedChatUIDemo(),
    ),
    GoRoute(
      path: '/m3_demo',
      builder: (context, state) => const Material3ChatUIDemo(),
    ),
    GoRoute(
      path: '/unified_demo',
      builder: (context, state) => const UnifiedChatUIDemo(),
    ),
  ],
);