/// 决策卡片专用设计令牌
/// 
/// 提取自1.html的视觉规范，包含颜色、间距、字体等核心设计变量
library;

import 'package:flutter/material.dart';

/// 决策卡片设计令牌
class DecisionCardTheme {
  DecisionCardTheme._();

  // ==================== 颜色令牌 ====================

  /// 主背景渐变
  static const LinearGradient bgDeep = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF090E16), Color(0xFF0A1220)],
  );

  /// 提升背景渐变
  static const LinearGradient bgElevated = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x48101C30), Color(0x5909101E)], // rgba(16,28,48,0.28), rgba(9,16,30,0.35)
  );

  /// 弱边框色
  static const Color lineWeak = Color(0xFF162339);

  /// 强边框色
  static const Color lineStrong = Color(0xFF223650);

  /// 主文字色
  static const Color textMain = Color(0xFFD9E5FF);

  /// 次文字色
  static const Color textDim = Color(0xFF8FA0BF);

  /// 按钮背景色
  static const Color btnBackground = Color(0xFF0E1A2D);

  /// 按钮悬停色
  static const Color btnHover = Color(0xFF15263F);

  /// 按钮激活色
  static const Color btnActive = Color(0xFF132745);

  /// 按钮激活发光色
  static const Color btnActiveGlow = Color(0x242AA8FF); // rgba(42,168,255,0.14)

  /// 按钮激活边框色
  static const Color btnBorderActive = Color(0xFF254569);

  /// 按钮边框色
  static const Color btnBorder = Color(0xFF223650);

  /// 主强调色（蓝色）
  static const Color accent = Color(0xFF2AA8FF);

  /// 强调色-柔和
  static const Color accentSoft = Color(0x592AA8FF); // rgba(42,168,255,0.35)

  /// 强调色-微弱
  static const Color accentFaint = Color(0x1F2AA8FF); // rgba(42,168,255,0.12)

  // ==================== 间距令牌 ====================

  /// 基础间距单位
  static const double spacingBase = 12.0;

  /// 卡片横向内边距
  static const double cardPaddingHorizontal = 14.0;

  /// 卡片底部内边距
  static const double cardPaddingBottom = 16.0;

  /// 头部内边距
  static const double headerPadding = 14.0;

  /// 按钮内边距（横向/纵向）
  static const double buttonPaddingVertical = 12.0;
  static const double buttonPaddingLeft = 14.0;
  static const double buttonPaddingRight = 34.0;

  /// 按钮组间距
  static const double buttonGroupGap = 10.0;

  /// 按钮组顶部边距
  static const double buttonGroupPaddingTop = 10.0;

  /// Tips面板间距
  static const double tipsPanelPadding = 12.0;
  static const double tipsPanelMarginTop = 12.0;
  static const double tipsPanelGap = 12.0;

  /// 切角大小
  static const double notchSize = 10.0;

  // ==================== 字体令牌 ====================

  /// 字体族
  static const String fontFamily = 'SF Pro Display';

  /// 标题字号
  static const double titleFontSize = 13.0;

  /// 标题字重
  static const FontWeight titleFontWeight = FontWeight.w600;

  /// 标题字间距
  static const double titleLetterSpacing = 0.3;

  /// 副标题字号
  static const double subtitleFontSize = 11.0;

  /// 副标题上边距
  static const double subtitleMarginTop = 2.0;

  /// 按钮文字字号
  static const double buttonFontSize = 12.5;

  /// 按钮文字字重
  static const FontWeight buttonFontWeight = FontWeight.w500;

  /// 确认按钮字号
  static const double confirmButtonFontSize = 12.5;

  /// 确认按钮字重
  static const FontWeight confirmButtonFontWeight = FontWeight.w600;

  /// 确认按钮字间距
  static const double confirmButtonLetterSpacing = 0.2;

  /// Tips标题字号
  static const double tipsTitleFontSize = 10.5;

  /// Tips标题字间距
  static const double tipsTitleLetterSpacing = 0.45;

  /// Tips标题下边距
  static const double tipsTitleMarginBottom = 4.0;

  /// Tips内容字号
  static const double tipsContentFontSize = 12.0;

  /// Tips内容行高
  static const double tipsContentLineHeight = 1.6;

  /// 切换文字字号
  static const double toggleTextFontSize = 11.0;

  // ==================== 圆角令牌 ====================

  /// 按钮选中标记圆角
  static const double selectionIndicatorRadius = 2.0;

  // ==================== 阴影令牌 ====================

  /// 卡片阴影
  static List<BoxShadow> get cardShadow => [
        const BoxShadow(
          color: Color(0x8C000000), // rgba(0,0,0,0.55)
          offset: Offset(0, 14),
          blurRadius: 38,
          spreadRadius: 0,
        ),
      ];

  /// 卡片内高光（需要通过自定义Painter实现）
  static const Color cardInnerGlowColor = Color(0x08FFFFFF); // rgba(255,255,255,0.03)

  /// 按钮阴影
  static List<BoxShadow> get buttonShadow => [
        const BoxShadow(
          color: Color(0x47000000), // rgba(0,0,0,0.28)
          offset: Offset(0, 6),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];

  /// 按钮内高光颜色
  static const Color buttonInnerGlowColor = Color(0x08FFFFFF); // rgba(255,255,255,0.03)

  /// 按钮悬停阴影
  static List<BoxShadow> get buttonHoverShadow => [
        const BoxShadow(
          color: Color(0x52000000), // rgba(0,0,0,0.32)
          offset: Offset(0, 8),
          blurRadius: 18,
          spreadRadius: 0,
        ),
      ];

  /// 按钮选中阴影
  static List<BoxShadow> get buttonActiveShadow => [
        const BoxShadow(
          color: Color(0x47000000), // rgba(0,0,0,0.28)
          offset: Offset(0, 6),
          blurRadius: 16,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: btnActiveGlow,
          offset: Offset.zero,
          blurRadius: 18,
          spreadRadius: 0,
        ),
      ];

  /// 确认按钮阴影
  static List<BoxShadow> get confirmButtonShadow => [
        const BoxShadow(
          color: Color(0x59000000), // rgba(0,0,0,0.35)
          offset: Offset(0, 8),
          blurRadius: 22,
          spreadRadius: 0,
        ),
      ];

  /// 确认按钮内高光颜色
  static const Color confirmButtonInnerGlowColor = Color(0x08FFFFFF); // rgba(255,255,255,0.03)

  /// 确认按钮悬停阴影
  static List<BoxShadow> get confirmButtonHoverShadow => [
        const BoxShadow(
          color: Color(0x6B000000), // rgba(0,0,0,0.42)
          offset: Offset(0, 10),
          blurRadius: 26,
          spreadRadius: 0,
        ),
      ];

  /// 确认按钮悬停内高光颜色
  static const Color confirmButtonHoverInnerGlowColor = Color(0x142AA8FF); // rgba(42,168,255,0.08)

  /// 确认按钮禁用阴影
  static List<BoxShadow> get confirmButtonDisabledShadow => [
        const BoxShadow(
          color: Color(0x40000000), // rgba(0,0,0,0.25)
          offset: Offset(0, 6),
          blurRadius: 18,
          spreadRadius: 0,
        ),
      ];

  /// 确认按钮禁用内高光颜色
  static const Color confirmButtonDisabledInnerGlowColor = Color(0x05FFFFFF); // rgba(255,255,255,0.02)

  /// Tips面板阴影
  static List<BoxShadow> get tipsPanelShadow => [
        const BoxShadow(
          color: Color(0x47000000), // rgba(0,0,0,0.28)
          offset: Offset(0, -6),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ];

  /// Tips面板内高光颜色
  static const Color tipsPanelInnerGlowColor = Color(0x08FFFFFF); // rgba(255,255,255,0.03)

  /// 选中标记阴影
  static List<BoxShadow> get selectionIndicatorShadow => [
        const BoxShadow(
          color: Color(0x292AA8FF), // rgba(42,168,255,0.16)
          offset: Offset(0, 0),
          blurRadius: 2,
          spreadRadius: 0,
          blurStyle: BlurStyle.normal,
        ),
        const BoxShadow(
          color: Color(0x382AA8FF), // rgba(42,168,255,0.22)
          offset: Offset(0, 0),
          blurRadius: 10,
          spreadRadius: 0,
          blurStyle: BlurStyle.normal,
        ),
      ];

  // ==================== 尺寸令牌 ====================

  /// 卡片最大宽度
  static const double cardMaxWidth = 980.0;

  /// 按钮最小宽度
  static const double buttonMinWidth = 112.0;

  /// 选中标记大小
  static const double selectionIndicatorSize = 10.0;

  /// 选中标记右边距
  static const double selectionIndicatorRightMargin = 12.0;

  // ==================== 动画令牌 ====================

  /// 卡片呼吸动画时长
  static const Duration cardGlowDuration = Duration(seconds: 12);

  /// 按钮流光动画时长
  static const Duration buttonSheenDuration = Duration(seconds: 9);

  /// 选中动画时长
  static const Duration selectionAnimationDuration = Duration(milliseconds: 180);

  /// 悬停动画时长
  static const Duration hoverAnimationDuration = Duration(milliseconds: 150);

  /// 激活动画时长
  static const Duration activeAnimationDuration = Duration(milliseconds: 150);

  /// 顶部流动线动画时长
  static const Duration auroraRunDuration = Duration(milliseconds: 7800);

  /// 缓动曲线
  static const Curve easeOut = Cubic(0.0, 0.0, 0.2, 1);
  static const Curve easeIn = Cubic(0.4, 0.0, 1, 1);
  static const Curve easeInOut = Cubic(0.4, 0.0, 0.2, 1);

  // ==================== 响应式断点 ====================

  /// 桌面端最小宽度
  static const double desktopBreakpoint = 880.0;

  // ==================== 渐变令牌 ====================

  /// 确认按钮背景渐变
  static const LinearGradient confirmButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF10233C), Color(0xFF0D1E34)],
  );

  /// 确认按钮悬停渐变
  static const LinearGradient confirmButtonHoverGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF132A44), Color(0xFF10233C)],
  );

  /// 确认按钮激活渐变
  static const LinearGradient confirmButtonActiveGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F2036), Color(0xFF0C1B2F)],
  );

  /// 按钮选中渐变
  static const LinearGradient buttonSelectedGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF162D4A), Color(0xFF132745)],
  );

  /// Tips面板背景渐变
  static const LinearGradient tipsPanelBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xB80C1628), Color(0xDC09101E)], // rgba(12,22,40,0.72), rgba(9,16,30,0.86)
  );

  /// 卡片头部背景渐变
  static const LinearGradient cardHeaderBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x05FFFFFF), Color(0x00FFFFFF)], // rgba(255,255,255,0.02), transparent
  );

  /// 卡片柔光渐变
  static const RadialGradient cardGlowGradient = RadialGradient(
    center: Alignment(0.25, 0.0),
    radius: 0.8,
    colors: [Color(0x0AFFFFFF), Color(0x00FFFFFF)], // rgba(255,255,255,0.04), transparent
  );

  /// 按钮流光渐变
  static const LinearGradient buttonSheenGradient = LinearGradient(
    begin: Alignment(-0.5, 0.0),
    end: Alignment(1.5, 0.0),
    colors: [
      Color(0x00FFFFFF),
      Color(0x0DFFFFFF), // rgba(255,255,255,0.05)
      Color(0x00FFFFFF),
    ],
  );

  /// 顶部流动线渐变
  static const LinearGradient auroraGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x00FFFFFF),
      Color(0x8C2AA8FF), // rgba(42,168,255,0.55)
      Color(0x00FFFFFF),
    ],
  );

  // ==================== 透明度令牌 ====================

  /// 次文字透明度
  static const double textDimOpacity = 0.85;

  /// 切换文字透明度
  static const double toggleTextOpacity = 0.7;

  /// 切换文字激活透明度
  static const double toggleTextActiveOpacity = 1.0;

  /// 选中标记透明度
  static const double selectionIndicatorOpacity = 0.95;

  /// 卡片呼吸光最小透明度
  static const double cardGlowMinOpacity = 0.25;

  /// 卡片呼吸光最大透明度
  static const double cardGlowMaxOpacity = 0.38;

  /// 按钮流光透明度
  static const double buttonSheenOpacity = 0.06;

  /// 顶部流动线透明度
  static const double auroraOpacity = 0.55;

  /// 确认按钮禁用透明度
  static const double confirmButtonDisabledOpacity = 0.5;

  /// 内边框高光透明度
  static const double innerGlowOpacity = 0.06;

  /// 顶部虚线透明度
  static const double topDashedLineOpacity = 0.06;
}
