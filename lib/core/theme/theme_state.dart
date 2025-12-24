import 'package:flutter/material.dart';
import 'design_tokens.dart';

/// 全局主题状态
class ThemeState {
  /// 主题模式 (system, light, dark)
  final ThemeMode themeMode;

  /// Material 3 动态取色种子
  final Color seedColor;

  /// 全局字体
  final String? fontFamily;

  /// 自定义圆角系数 (影响组件的圆角大小)
  /// 默认 1.0 (8.0), 0.5 (4.0), 1.5 (12.0)
  final double customBorderRadius;

  /// 构造函数
  const ThemeState({
    this.themeMode = ThemeMode.dark,
    this.seedColor = DesignTokens.primaryColor,
    this.fontFamily,
    this.customBorderRadius = 1.0,
  });

  /// 复制并更新
  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? seedColor,
    String? fontFamily,
    double? customBorderRadius,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
      fontFamily: fontFamily ?? this.fontFamily,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
    );
  }

  /// 转换 JSON (预留)
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'seedColor': seedColor.value,
      'fontFamily': fontFamily,
      'customBorderRadius': customBorderRadius,
    };
  }

  /// 从 JSON 恢复 (预留)
  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: ThemeMode.values[json['themeMode'] as int],
      seedColor: Color(json['seedColor'] as int),
      fontFamily: json['fontFamily'] as String?,
      customBorderRadius: (json['customBorderRadius'] as num?)?.toDouble() ?? 1.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState &&
        other.themeMode == themeMode &&
        other.seedColor == seedColor &&
        other.fontFamily == fontFamily &&
        other.customBorderRadius == customBorderRadius;
  }

  @override
  int get hashCode => Object.hash(
        themeMode,
        seedColor,
        fontFamily,
        customBorderRadius,
      );
}
