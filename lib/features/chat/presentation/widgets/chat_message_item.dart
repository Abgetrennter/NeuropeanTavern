import 'package:flutter/material.dart';
import 'message_status_slot.dart';

class ChatMessageItem extends StatelessWidget {
  final String name;
  final String content;
  final bool isUser;
  final Map<String, dynamic>? metadata;
  final ColorScheme colorScheme;

  const ChatMessageItem({
    super.key,
    required this.name,
    required this.content,
    required this.isUser,
    this.metadata,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
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
              : colorScheme.secondaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isUser) ...[
              CircleAvatar(
                radius: 20,
                backgroundColor: colorScheme.primary.withValues(alpha: 0.2),
                child: Text(
                  name.isNotEmpty ? name[0] : '?',
                  style: TextStyle(color: colorScheme.primary),
                ),
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
                  // 插入状态槽
                  if (!isUser)
                    MessageStatusSlot(
                      metadata: metadata,
                      colorScheme: colorScheme,
                    ),
                ],
              ),
            ),
            if (isUser) ...[
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 20,
                backgroundColor: colorScheme.primary,
                child: Text(
                  name.isNotEmpty ? name[0] : '?',
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}