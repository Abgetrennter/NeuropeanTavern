import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/adaptive_scaffold.dart';
import '../../../../core/presentation/widgets/atomic/atom_button.dart';
import '../../../../core/presentation/widgets/atomic/atom_input.dart';
import '../../../../core/presentation/widgets/atomic/atom_avatar.dart';
import '../../../../core/utils/breakpoints.dart';

class AtomizedChatUIDemo extends StatelessWidget {
  const AtomizedChatUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(title: const Text('Atomic Chat UI Demo')),
      body: _buildBody(context),
      // navigationRail: ..., // Add if needed for demo
    );
  }

  Widget _buildBody(BuildContext context) {
    // 简单演示响应式判断
    final width = MediaQuery.of(context).size.width;
    final isMobile = ResponsiveUtils.isMobile(width);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Mode: ${isMobile ? "Mobile" : "Desktop/Tablet"}'),
          const SizedBox(height: 20),
          const AtomAvatar(
            size: AtomAvatarSize.medium,
            status: OnlineStatus.online,
            fallbackText: 'AI',
          ),
          const SizedBox(height: 20),
          const AtomInput(
            hintText: 'Type something...',
            prefixIcon: Icon(Icons.chat),
          ),
          const SizedBox(height: 20),
          AtomButton(
            label: 'Send Message',
            icon: Icons.send,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
