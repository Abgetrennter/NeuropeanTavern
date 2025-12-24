import 'package:flutter/material.dart';
import 'design_tokens.dart';
import 'app_colors.dart';
import 'theme_state.dart';

class AppTheme {
  /// 获取应用主题配置
  /// 
  /// [state] 包含动态主题配置 (seedColor, fontFamily, etc.)
  /// [brightness] 用于指定明暗模式
  static ThemeData getTheme(ThemeState state, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    // 基础 ColorScheme (基于 seedColor 动态生成)
    final colorScheme = ColorScheme.fromSeed(
      seedColor: state.seedColor,
      brightness: brightness,
      // 保持主色一致性，除非用户特意修改 seedColor
      primary: state.seedColor,
      // 在深色模式下，Surface 使用特定背景色 (如果 seedColor 是默认值)
      surface: isDark && state.seedColor == DesignTokens.primaryColor 
          ? DesignTokens.pageBackgroundColor 
          : null, // 如果用户自定义了颜色，让 Material3 自动计算 surface
      
      // 错误色
      error: isDark ? DesignTokens.errorColor : AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      
      // 应用动态字体
      fontFamily: state.fontFamily ?? DesignTokens.fontFamily,
      
      // 文本样式覆盖 (仅在默认字体时应用微调，自定义字体时交由 M3 处理)
      textTheme: state.fontFamily == null ? TextTheme(
        bodyLarge: TextStyle(
          fontSize: DesignTokens.fontSizeBase,
          color: isDark ? DesignTokens.bodyColor : Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: DesignTokens.fontSizeSm,
          color: isDark ? DesignTokens.bodyColor : Colors.black87,
        ),
        labelSmall: TextStyle(
          fontSize: DesignTokens.fontSizeXs,
          color: isDark ? DesignTokens.emphasisColor : Colors.black54,
        ),
      ) : null,
      
      // 分隔线样式
      dividerTheme: DividerThemeData(
        color: isDark ? DesignTokens.grey50 : Colors.black12,
        thickness: 1,
      ),

      // 图标样式
      iconTheme: IconThemeData(
        color: isDark ? DesignTokens.bodyColor : Colors.black87,
        size: DesignTokens.topBarIconSize,
      ),

      // 卡片主题 (受 customBorderRadius 影响)
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.borderRadius * state.customBorderRadius),
        ),
      ),
      
      // 按钮主题 (受 customBorderRadius 影响)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.borderRadius * state.customBorderRadius),
          ),
        ),
      ),
    );
  }
}
