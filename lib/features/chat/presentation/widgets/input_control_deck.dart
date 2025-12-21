import 'package:flutter/material.dart';

class InputControlDeck extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSendMessage;
  final VoidCallback onShowStatus;
  final ColorScheme colorScheme;

  const InputControlDeck({
    super.key,
    required this.textController,
    required this.onSendMessage,
    required this.onShowStatus,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                onPressed: onShowStatus,
                tooltip: 'Show Status',
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          // 输入行
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: TextStyle(color: colorScheme.onSurface),
                  minLines: 1,
                  maxLines: 5,
                ),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                onPressed: onSendMessage,
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                elevation: 0,
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}