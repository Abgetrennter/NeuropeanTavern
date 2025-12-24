import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_provider.dart';

class DebugMenuPage extends ConsumerWidget {
  const DebugMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleThemeMode();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuButton(
            context,
            'Chat Page',
            '/chat',
            Icons.chat,
          ),
          const SizedBox(height: 16),
          _buildMenuButton(
            context,
            'Atomized Chat UI Demo',
            '/demo',
            Icons.view_quilt,
          ),
          const SizedBox(height: 16),
          _buildMenuButton(
            context,
            'Unified Chat UI Demo',
            '/unified_demo',
            Icons.merge_type,
          ),
          const SizedBox(height: 16),
          _buildMenuButton(
            context,
            'Test Panel',
            '/test',
            Icons.science,
          ),
           const SizedBox(height: 16),
           _buildMenuButton(
            context,
            'Material 3 Chat UI Demo',
            '/m3_demo',
            Icons.palette,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => context.push(route),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
