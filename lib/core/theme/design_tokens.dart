import 'package:flutter/material.dart';

/// 设计令牌系统
/// 基于 doc/design-specs/01-设计令牌.md 和 doc/design-specs/02-颜色系统.md
/// 提供统一的设计变量，确保视觉一致性
class DesignTokens {
  DesignTokens._();

  // ==================== 颜色令牌 ====================

  /// 主题颜色
  static const Color primaryColor = Color(0xFFE18A24); // SmartThemeQuoteColor
  static const Color bodyColor = Color(0xFFDCDCD2); // SmartThemeBodyColor
  static const Color emphasisColor = Color(0xFF919191); // SmartThemeEmColor

  /// 背景色调
  static const Color blurTintColor = Color(0xFF171717); // SmartThemeBlurTintColor
  static const Color chatTintColor = Color(0xFF171717); // SmartThemeChatTintColor
  static const Color pageBackgroundColor = Color(0xFF242425); // --greyCAIbg

  /// 消息背景色调
  static const Color userMessageTint = Color(0x4D000000); // rgba(0, 0, 0, 0.3)
  static const Color botMessageTint = Color(0x4D3C3C3C); // rgba(60, 60, 60, 0.3)

  /// 阴影颜色
  static const Color shadowColor = Color(0x80000000); // rgba(0, 0, 0, 0.5)

  /// 边框颜色
  static const Color borderColor = Color(0x80000000); // rgba(0, 0, 0, 0.5)

  /// 灰度系统
  static const Color grey10 = Color(0xFF191919);
  static const Color grey30 = Color(0xFF4B4B4B);
  static const Color grey50 = Color(0xFF7D7D7D);
  static const Color grey70 = Color(0xFFAFAFAF);
  static const Color grey75 = Color(0xFFBEBEBE);

  // ==================== 语义化颜色 ====================

  /// 成功/激活
  static const Color successColor = Color(0xFF58B600);
  static const Color successBackground = Color(0xB2006400); // rgba(0, 100, 0, 0.7)

  /// 警告/错误
  static const Color warningColor = Color(0xE6FF0000); // rgba(255, 0, 0, 0.9)
  static const Color errorColor = Color(0xFFFF0000);
  static const Color errorBackground = Color(0xB2640000); // rgba(100, 0, 0, 0.7)
  static const Color errorHover = Color(0x80963232); // rgba(150, 50, 50, 0.5)

  /// 重要/优先
  static const Color preferredColor = Color(0xFFF44336);

  /// 信息提示
  static const Color infoBackground = Color(0x4D6464FF); // rgba(100, 100, 255, 0.3)

  /// 特殊色
  static const Color goldenColor = Color(0xFFF8D300);

  // ==================== 透明度变体 ====================

  /// 黑色透明度
  static const Color black30a = Color(0x4D000000);
  static const Color black40a = Color(0x66000000);
  static const Color black50a = Color(0x80000000);
  static const Color black60a = Color(0x99000000);
  static const Color black70a = Color(0xB3000000);
  static const Color black90a = Color(0xE6000000);

  /// 白色透明度
  static const Color white20a = Color(0x33FFFFFF);
  static const Color white30a = Color(0x4DFFFFFF);
  static const Color white50a = Color(0x80FFFFFF);
  static const Color white60a = Color(0x99FFFFFF);
  static const Color white70a = Color(0xB3FFFFFF);
  static const Color white100 = Color(0xFFFFFFFF);

  /// 灰色透明度
  static const Color grey30a = Color(0x4D323232);
  static const Color grey5020a = Color(0x337D7D7D);
  static const Color grey5050a = Color(0x807D7D7D);
  static const Color grey7070a = Color(0xB3AFAFAF);

  // ==================== 间距令牌 ====================

  /// 基于主字体大小 15px 的间距系统
  static const double spacingBase = 15.0;
  static const double spacingXs = 3.75; // 0.25 * base
  static const double spacingSm = 7.5; // 0.5 * base
  static const double spacingMd = 15.0; // 1.0 * base
  static const double spacingLg = 22.5; // 1.5 * base
  static const double spacingXl = 30.0; // 2.0 * base
  static const double spacing2xl = 45.0; // 3.0 * base

  /// 组件专用间距
  static const double bottomFormBlockPadding = 6.0; // base / 2.5
  static const double bottomFormIconSize = 28.5; // base * 1.9
  static const double bottomFormBlockSize = 34.5; // iconSize + padding
  static const double topBarIconSize = 30.0; // base * 2
  static const double topBarBlockPadding = 5.0; // base / 3
  static const double topBarBlockSize = 35.0; // iconSize + padding
  static const double messageRightSpacing = 30.0;

  // ==================== 字体令牌 ====================

  /// 字体族
  static const String fontFamily = 'Noto Sans';
  static const String monoFontFamily = 'Noto Sans Mono';

  /// 字号系统（基于 15px 基准）
  static const double fontSizeBase = 15.0;
  static const double fontSizeXs = 12.0; // 0.8 * base
  static const double fontSizeSm = 13.5; // 0.9 * base
  static const double fontSizeMd = 15.0; // 1.0 * base
  static const double fontSizeLg = 18.0; // 1.2 * base
  static const double fontSizeXl = 22.5; // 1.5 * base
  static const double fontSize2xl = 30.0; // 2.0 * base

  /// 行高
  static const double lineHeightBase = 1.5;
  static const double lineHeightTight = 1.25;
  static const double lineHeightLoose = 1.75;

  // ==================== 阴影令牌 ====================

  /// 阴影宽度
  static const double shadowWidth = 2.0;

  /// 阴影层级
  static List<BoxShadow> get elevation1 => [
        BoxShadow(
          color: shadowColor,
          offset: const Offset(0, 1),
          blurRadius: 2,
        ),
      ];

  static List<BoxShadow> get elevation2 => [
        BoxShadow(
          color: shadowColor,
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ];

  static List<BoxShadow> get elevation3 => [
        BoxShadow(
          color: shadowColor,
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ];

  static List<BoxShadow> get elevation4 => [
        BoxShadow(
          color: shadowColor,
          offset: const Offset(0, 8),
          blurRadius: 16,
        ),
      ];

  // ==================== 模糊令牌 ====================

  /// 模糊强度
  static const double blurStrength = 10.0;
  static const double blurLight = 5.0;
  static const double blurHeavy = 20.0;
  static const double blurDouble = 20.0; // blurStrength * 2

  // ==================== 边框令牌 ====================

  /// 圆角
  static const double borderRadius = 8.0; // 基础圆角
  static const double borderRadiusSm = 2.0;
  static const double borderRadiusMd = 5.0;
  static const double borderRadiusLg = 10.0;
  static const double borderRadiusXl = 12.0;
  static const double borderRadiusFull = 9999.0;

  /// 边框宽度
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 2.0;
  static const double borderWidthThick = 3.0;

  // ==================== 动画令牌 ====================

  /// 动画时长
  static const Duration animationDuration = Duration(milliseconds: 125);
  static const Duration animationDuration2x = Duration(milliseconds: 250);
  static const Duration animationDuration3x = Duration(milliseconds: 375);

  /// 缓动曲线
  static const Curve easeIn = Cubic(0.4, 0.0, 1, 1);
  static const Curve easeOut = Cubic(0.0, 0.0, 0.2, 1);
  static const Curve easeInOut = Cubic(0.4, 0.0, 0.2, 1);
  static const Curve easeSharp = Cubic(0.4, 0.0, 0.6, 1);

  // ==================== 尺寸令牌 ====================

  /// 头像尺寸
  static const double avatarSmall = 40.0;
  static const double avatarMedium = 50.0;
  static const double avatarLarge = 60.0;
  static const double avatarXLarge = 100.0;

  /// 容器尺寸
  static const double sheldWidth = 0.5; // 50vw as ratio

  // ==================== 辅助方法 ====================

  /// 获取带透明度的颜色
  static Color withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }

  /// 获取带模糊的阴影
  static List<BoxShadow> getBlurShadow({
    Color? color,
    double blur = 10.0,
    Offset offset = Offset.zero,
  }) {
    return [
      BoxShadow(
        color: (color ?? shadowColor).withValues(alpha: 0.3),
        offset: offset,
        blurRadius: blur,
      ),
    ];
  }
}
