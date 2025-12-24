import 'package:flutter/material.dart';
import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/theme/app_colors.dart';

enum SwipeAction {
  edit,
  regenerate,
  delete,
  reply,
}

/// 可滑动消息组件
/// 
/// 支持左右滑动手势，触发快捷操作
class SwipeableMessage extends StatefulWidget {
  final Widget child;
  final ValueChanged<SwipeAction>? onSwipeLeft;
  final ValueChanged<SwipeAction>? onSwipeRight;
  final bool enabled;

  const SwipeableMessage({
    super.key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.enabled = true,
  });

  @override
  State<SwipeableMessage> createState() => _SwipeableMessageState();
}

class _SwipeableMessageState extends State<SwipeableMessage> {
  // 阈值：滑动超过此比例触发操作
  static const double _threshold = 0.25;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return Dismissible(
      key: UniqueKey(), // 在实际列表中应使用稳定的 key
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          widget.onSwipeLeft?.call(SwipeAction.edit);
        } else {
          widget.onSwipeRight?.call(SwipeAction.reply);
        }
        // 返回 false 以防止项被移除，我们只借用手势
        return false;
      },
      background: _buildSwipeBackground(
        alignment: Alignment.centerLeft,
        icon: Icons.reply,
        color: DesignTokens.primaryColor,
        label: 'Reply',
      ),
      secondaryBackground: _buildSwipeBackground(
        alignment: Alignment.centerRight,
        icon: Icons.edit,
        color: DesignTokens.emphasisColor,
        label: 'Edit',
      ),
      child: widget.child,
    );
  }

  Widget _buildSwipeBackground({
    required Alignment alignment,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.spacingLg),
      color: Colors.transparent, // 透明背景，让图标悬浮
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (alignment == Alignment.centerRight) ...[
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: DesignTokens.spacingSm),
          ],
          
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),

          if (alignment == Alignment.centerLeft) ...[
            SizedBox(width: DesignTokens.spacingSm),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
