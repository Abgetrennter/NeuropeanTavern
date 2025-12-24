/// 响应式断点系统
/// 
/// 基于 Material 3 标准和项目需求定义
class Breakpoints {
  Breakpoints._();

  /// 移动端断点 (<= 600)
  /// 适用于手机
  static const double mobile = 600.0;

  /// 平板端断点 (> 600 && <= 1200)
  /// 适用于平板电脑、折叠屏
  static const double tablet = 1200.0;

  /// 桌面端断点 (> 1200)
  /// 适用于桌面显示器
  static const double desktop = 1200.0;
}

/// 布局模式枚举
enum LayoutMode {
  mobile,
  tablet,
  desktop,
}

/// 响应式工具类
class ResponsiveUtils {
  /// 获取当前布局模式
  static LayoutMode getLayoutMode(double width) {
    if (width <= Breakpoints.mobile) return LayoutMode.mobile;
    if (width <= Breakpoints.tablet) return LayoutMode.tablet;
    return LayoutMode.desktop;
  }

  /// 是否为移动端
  static bool isMobile(double width) => width <= Breakpoints.mobile;

  /// 是否为平板端
  static bool isTablet(double width) => width > Breakpoints.mobile && width <= Breakpoints.tablet;

  /// 是否为桌面端
  static bool isDesktop(double width) => width > Breakpoints.desktop;
}
