import 'package:flutter/material.dart';
import '../../../theme/design_tokens.dart';
import '../../../theme/app_colors.dart';

enum AtomAvatarSize {
  small(DesignTokens.avatarSmall),
  medium(DesignTokens.avatarMedium),
  large(DesignTokens.avatarLarge),
  xlarge(DesignTokens.avatarXLarge);

  final double size;
  const AtomAvatarSize(this.size);
}

enum OnlineStatus {
  online,
  offline,
  busy,
}

/// 原子化头像组件
/// 
/// 支持尺寸变体和在线状态指示
class AtomAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? fallbackText;
  final AtomAvatarSize size;
  final OnlineStatus? status;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const AtomAvatar({
    super.key,
    this.imageUrl,
    this.fallbackText,
    this.size = AtomAvatarSize.medium,
    this.status,
    this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: SizedBox(
          width: size.size,
          height: size.size,
          child: Stack(
            children: [
              // 头像主体
              _buildAvatarContainer(),
              
              // 在线状态指示器
              if (status != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: _buildStatusIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarContainer() {
    return Container(
      width: size.size,
      height: size.size,
      decoration: BoxDecoration(
        color: backgroundColor ?? DesignTokens.grey50, // 占位背景色或自定义
        shape: BoxShape.circle,
        border: Border.all(
          color: DesignTokens.borderColor,
          width: 2,
        ),
        boxShadow: DesignTokens.elevation1,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                fallbackText?.isNotEmpty == true ? fallbackText![0].toUpperCase() : '?',
                style: TextStyle(
                  color: textColor ?? DesignTokens.bodyColor,
                  fontSize: size.size * 0.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildStatusIndicator() {
    Color statusColor;
    switch (status!) {
      case OnlineStatus.online:
        statusColor = AppColors.success;
        break;
      case OnlineStatus.offline:
        statusColor = DesignTokens.grey50;
        break;
      case OnlineStatus.busy:
        statusColor = AppColors.warning;
        break;
    }

    // 指示器大小根据头像大小动态调整
    final indicatorSize = size.size * 0.25;

    return Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: BoxDecoration(
        color: statusColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: DesignTokens.pageBackgroundColor, // 边框颜色与背景一致，形成镂空效果
          width: 2,
        ),
      ),
    );
  }
}
