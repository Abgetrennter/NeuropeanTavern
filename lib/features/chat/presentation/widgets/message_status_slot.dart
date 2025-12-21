import 'package:flutter/material.dart';

enum StatusSlotType {
  none,
  native, // RFW
  web, // WebView
}

class MessageStatusSlot extends StatelessWidget {
  final Map<String, dynamic>? metadata;
  final ColorScheme colorScheme;

  const MessageStatusSlot({
    super.key,
    this.metadata,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    if (metadata == null || !metadata!.containsKey('status_type')) {
      return const SizedBox.shrink();
    }

    final typeStr = metadata!['status_type'] as String;
    final type = StatusSlotType.values.firstWhere(
      (e) => e.name == typeStr,
      orElse: () => StatusSlotType.none,
    );

    if (type == StatusSlotType.none) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / Debug Info
          Row(
            children: [
              Icon(
                type == StatusSlotType.native ? Icons.widgets : Icons.web,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                type == StatusSlotType.native ? 'Native Extension' : 'Web Fallback',
                style: TextStyle(
                  fontSize: 10,
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          // Content Placeholder
          if (type == StatusSlotType.native)
            _buildNativePlaceholder(context)
          else
            _buildWebPlaceholder(context),
        ],
      ),
    );
  }

  Widget _buildNativePlaceholder(BuildContext context) {
    // Future: RFW Widget Builder
    return SizedBox(
      height: 60,
      child: Center(
        child: Text(
          'RFW Layout Placeholder\n(ID: ${metadata!['extension_id']})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildWebPlaceholder(BuildContext context) {
    // Future: WebView Widget
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          'WebView Placeholder\n(Source: ${metadata!['url']})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}