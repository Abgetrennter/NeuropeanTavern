import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_state.dart';
import 'design_tokens.dart';

/// 主题状态管理器
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState());

  /// 更新主题模式
  void updateThemeMode(ThemeMode mode) {
    if (state.themeMode != mode) {
      state = state.copyWith(themeMode: mode);
    }
  }

  /// 切换主题模式 (Light <-> Dark)
  void toggleThemeMode() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    updateThemeMode(newMode);
  }

  /// 更新主题色 (种子颜色)
  void updateSeedColor(Color color) {
    if (state.seedColor != color) {
      state = state.copyWith(seedColor: color);
    }
  }

  /// 重置为默认主题色
  void resetSeedColor() {
    if (state.seedColor != DesignTokens.primaryColor) {
      state = state.copyWith(seedColor: DesignTokens.primaryColor);
    }
  }

  /// 更新字体
  void updateFontFamily(String? fontFamily) {
    if (state.fontFamily != fontFamily) {
      state = state.copyWith(fontFamily: fontFamily);
    }
  }

  /// 更新自定义圆角系数
  void updateCustomBorderRadius(double value) {
    if (state.customBorderRadius != value) {
      state = state.copyWith(customBorderRadius: value);
    }
  }

  // TODO: 后续可在此添加持久化逻辑 (SharedPreferences)
}

/// 全局主题 Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
