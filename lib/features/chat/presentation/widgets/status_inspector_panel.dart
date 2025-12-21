import 'package:flutter/material.dart';

class StatusInspectorPanel extends StatelessWidget {
  final ColorScheme colorScheme;

  const StatusInspectorPanel({
    super.key,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
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
}