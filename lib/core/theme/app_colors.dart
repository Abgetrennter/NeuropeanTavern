import 'package:flutter/material.dart';

/// 语义化颜色系统
/// 基于 DesignTokens 提供业务场景相关的语义颜色
class AppColors {
  AppColors._();

  // ==================== 状态颜色 ====================

  /// 成功状态
  static const Color success = Color(0xFF58B600);
  static const Color successBg = Color(0xB2006400); // rgba(0, 100, 0, 0.7)

  /// 警告状态
  static const Color warning = Color(0xE6FF0000); // rgba(255, 0, 0, 0.9)

  /// 错误状态
  static const Color error = Color(0xFFFF0000);
  static const Color errorBg = Color(0xB2640000); // rgba(100, 0, 0, 0.7)
  static const Color errorHover = Color(0x80963232); // rgba(150, 50, 50, 0.5)

  /// 信息提示
  static const Color infoBg = Color(0x4D6464FF); // rgba(100, 100, 255, 0.3)

  // ==================== 业务语义 ====================

  /// 优先/重要
  static const Color preferred = Color(0xFFF44336);

  /// 收藏/高亮
  static const Color golden = Color(0xFFF8D300);

  // ==================== 交互反馈 ====================

  /// 激活状态
  static const Color active = Color(0xFF58B600);

  /// 焦点边框
  static const Color focusBorder = Color(0xFFFFFFFF);

  /// 交互轮廓
  static const Color interactableOutline = Color(0xFFFFFFFF);
  static const Color interactableOutlineFaint = Color(0x33FFFFFF);
}
