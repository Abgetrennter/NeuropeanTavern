import 'package:go_router/go_router.dart';
import '../../features/character/presentation/pages/test_panel_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/atomized_chat_ui_demo.dart';

final appRouter = GoRouter(
  initialLocation: '/demo',
  routes: [
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
  ],
);