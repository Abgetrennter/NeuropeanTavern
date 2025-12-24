import 'package:flutter/material.dart';
import '../../../../../core/presentation/widgets/atomic/atom_avatar.dart';
import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/presentation/widgets/effects/frosted_glass.dart';

enum MessageStatus {
  sending,
  sent,
  error,
  editing,
}

/// 消息气泡组件
/// 
/// 区分用户和AI的消息样式，支持毛玻璃效果和状态指示
class MessageBubble extends StatelessWidget {
  final String content;
  final bool isUser;
  final String? avatarUrl;
  final String? senderName;
  final MessageStatus status;
  final VoidCallback? onAvatarTap;
  final List<Widget>? actions;

  const MessageBubble({
    super.key,
    required this.content,
    required this.isUser,
    this.avatarUrl,
    this.senderName,
    this.status = MessageStatus.sent,
    this.onAvatarTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI 头像 (左侧)
          if (!isUser) ...[
            _buildAvatar(),
            SizedBox(width: DesignTokens.spacingSm),
          ],

          // 消息内容区
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // 发送者名字和时间戳 (可选)
                if (senderName != null)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: DesignTokens.spacingXs,
                      left: DesignTokens.spacingXs,
                      right: DesignTokens.spacingXs,
                    ),
                    child: Text(
                      senderName!,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeXs,
                        color: DesignTokens.emphasisColor,
                      ),
                    ),
                  ),

                // 气泡主体
                _buildBubbleContent(context),
                
                // 底部操作栏 (AI消息)
                if (!isUser && actions != null) ...[
                  SizedBox(height: DesignTokens.spacingXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
                ],
              ],
            ),
          ),

          // 用户头像 (右侧)
          if (isUser) ...[
            SizedBox(width: DesignTokens.spacingSm),
            _buildAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return AtomAvatar(
      size: AtomAvatarSize.medium,
      imageUrl: avatarUrl,
      fallbackText: senderName,
      onTap: onAvatarTap,
    );
  }

  Widget _buildBubbleContent(BuildContext context) {
    final bubbleColor = isUser 
        ? DesignTokens.userMessageTint 
        : DesignTokens.botMessageTint;

    final borderColor = status == MessageStatus.error 
        ? AppColors.error 
        : status == MessageStatus.editing 
            ? DesignTokens.primaryColor 
            : DesignTokens.borderColor;

    return FrostedGlass(
      blur: DesignTokens.blurStrength,
      borderRadius: DesignTokens.borderRadiusXl,
      color: bubbleColor,
      border: Border.all(color: borderColor),
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              height: DesignTokens.lineHeightBase,
              color: status == MessageStatus.sending 
                  ? DesignTokens.bodyColor.withValues(alpha: 0.6) 
                  : DesignTokens.bodyColor,
            ),
          ),
          
          // 状态指示器
          if (status == MessageStatus.sending) ...[
            SizedBox(height: DesignTokens.spacingXs),
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: DesignTokens.primaryColor,
              ),
            ),
          ],
          
          if (status == MessageStatus.error) ...[
             SizedBox(height: DesignTokens.spacingXs),
             Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Icon(Icons.error_outline, size: 14, color: AppColors.error),
                 SizedBox(width: 4),
                 Text(
                   '发送失败',
                   style: TextStyle(
                     fontSize: DesignTokens.fontSizeXs,
                     color: AppColors.error,
                   ),
                 ),
               ],
             ),
          ],
        ],
      ),
    );
  }
}
