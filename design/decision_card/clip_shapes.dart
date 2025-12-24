/// 切角形状定义
/// 
/// 提供带切角的容器形状，用于卡片、按钮等组件的视觉效果
library;

import 'package:flutter/material.dart';

/// 切角矩形形状
/// 
/// 实现1.html中的clip-path切角效果：
/// 顶部和底部各有两个10px的切角
class NotchRoundedRectangle extends ShapeBorder {
  /// 切角大小
  final double notchSize;

  /// 边框宽度
  final double borderWidth;

  /// 边框颜色
  final Color? borderColor;

  const NotchRoundedRectangle({
    this.notchSize = 10.0,
    this.borderWidth = 1.0,
    this.borderColor,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _createNotchPath(rect.deflate(borderWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _createNotchPath(rect);
  }

  /// 创建切角路径
  Path _createNotchPath(Rect rect) {
    final path = Path();
    final left = rect.left;
    final right = rect.right;
    final top = rect.top;
    final bottom = rect.bottom;

    // 从左上角切角开始
    path.moveTo(left, top + notchSize);
    // 左上切角
    path.lineTo(left + notchSize, top);
    // 顶部边
    path.lineTo(right - notchSize, top);
    // 右上切角
    path.lineTo(right, top + notchSize);
    // 右边
    path.lineTo(right, bottom - notchSize);
    // 右下切角
    path.lineTo(right - notchSize, bottom);
    // 底边
    path.lineTo(left + notchSize, bottom);
    // 左下切角
    path.lineTo(left, bottom - notchSize);
    // 左边
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (borderColor == null || borderWidth <= 0) return;

    final paint = Paint()
      ..color = borderColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return NotchRoundedRectangle(
      notchSize: notchSize * t,
      borderWidth: borderWidth * t,
      borderColor: borderColor,
    );
  }
}

/// 切角边框Painter
/// 
/// 用于绘制带切角的边框，支持内发光效果
class NotchBorderPainter extends CustomPainter {
  /// 切角大小
  final double notchSize;

  /// 边框宽度
  final double borderWidth;

  /// 边框颜色
  final Color borderColor;

  /// 内发光颜色
  final Color? innerGlowColor;

  /// 内发光宽度
  final double innerGlowWidth;

  const NotchBorderPainter({
    this.notchSize = 10.0,
    this.borderWidth = 1.0,
    required this.borderColor,
    this.innerGlowColor,
    this.innerGlowWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // 绘制内发光
    if (innerGlowColor != null && innerGlowWidth > 0) {
      final innerRect = rect.deflate(borderWidth);
      final innerPath = _createNotchPath(innerRect);
      
      final glowPaint = Paint()
        ..color = innerGlowColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = innerGlowWidth;

      canvas.drawPath(innerPath, glowPaint);
    }

    // 绘制主边框
    final path = _createNotchPath(rect);
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, borderPaint);
  }

  /// 创建切角路径
  Path _createNotchPath(Rect rect) {
    final path = Path();
    final left = rect.left;
    final right = rect.right;
    final top = rect.top;
    final bottom = rect.bottom;

    path.moveTo(left, top + notchSize);
    path.lineTo(left + notchSize, top);
    path.lineTo(right - notchSize, top);
    path.lineTo(right, top + notchSize);
    path.lineTo(right, bottom - notchSize);
    path.lineTo(right - notchSize, bottom);
    path.lineTo(left + notchSize, bottom);
    path.lineTo(left, bottom - notchSize);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant NotchBorderPainter oldDelegate) {
    return oldDelegate.notchSize != notchSize ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.innerGlowColor != innerGlowColor ||
        oldDelegate.innerGlowWidth != innerGlowWidth;
  }
}

/// 切角容器
/// 
/// 提供带切角效果的容器，支持自定义装饰
class NotchContainer extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 切角大小
  final double notchSize;

  /// 背景渐变
  final Gradient? gradient;

  /// 背景色（如果未提供gradient）
  final Color? backgroundColor;

  /// 边框宽度
  final double borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 内发光颜色
  final Color? innerGlowColor;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  const NotchContainer({
    super.key,
    required this.child,
    this.notchSize = 10.0,
    this.gradient,
    this.backgroundColor,
    this.borderWidth = 1.0,
    this.borderColor,
    this.innerGlowColor,
    this.boxShadow,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: backgroundColor,
        boxShadow: boxShadow,
      ),
      child: ClipPath(
        clipper: NotchClipper(notchSize: notchSize),
        child: CustomPaint(
          painter: borderColor != null || innerGlowColor != null
              ? NotchBorderPainter(
                  notchSize: notchSize,
                  borderWidth: borderWidth,
                  borderColor: borderColor ?? Colors.transparent,
                  innerGlowColor: innerGlowColor,
                )
              : null,
          child: child,
        ),
      ),
    );
  }
}

/// 切角裁剪器
class NotchClipper extends CustomClipper<Path> {
  /// 切角大小
  final double notchSize;

  const NotchClipper({this.notchSize = 10.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    path.moveTo(rect.left, rect.top + notchSize);
    path.lineTo(rect.left + notchSize, rect.top);
    path.lineTo(rect.right - notchSize, rect.top);
    path.lineTo(rect.right, rect.top + notchSize);
    path.lineTo(rect.right, rect.bottom - notchSize);
    path.lineTo(rect.right - notchSize, rect.bottom);
    path.lineTo(rect.left + notchSize, rect.bottom);
    path.lineTo(rect.left, rect.bottom - notchSize);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant NotchClipper oldDelegate) {
    return oldDelegate.notchSize != notchSize;
  }
}

/// 切角按钮样式
/// 
/// 预配置的切角按钮样式，用于快速创建切角按钮
class NotchButtonStyle {
  /// 切角大小
  final double notchSize;

  /// 边框宽度
  final double borderWidth;

  /// 边框颜色
  final Color borderColor;

  /// 内发光颜色
  final Color? innerGlowColor;

  /// 背景渐变
  final Gradient? gradient;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  const NotchButtonStyle({
    this.notchSize = 10.0,
    this.borderWidth = 1.0,
    required this.borderColor,
    this.innerGlowColor,
    this.gradient,
    this.boxShadow,
  });

  /// 创建默认按钮样式
  static NotchButtonStyle defaultButton({
    Color? borderColor,
    Color? innerGlowColor,
    Gradient? gradient,
    List<BoxShadow>? boxShadow,
  }) {
    return NotchButtonStyle(
      borderColor: borderColor ?? const Color(0xFF223650),
      innerGlowColor: innerGlowColor ?? const Color(0x08FFFFFF),
      gradient: gradient,
      boxShadow: boxShadow,
    );
  }

  /// 创建选中按钮样式
  static NotchButtonStyle selectedButton({
    Color? borderColor,
    Color? innerGlowColor,
    Gradient? gradient,
    List<BoxShadow>? boxShadow,
  }) {
    return NotchButtonStyle(
      borderColor: borderColor ?? const Color(0xFF254569),
      innerGlowColor: innerGlowColor,
      gradient: gradient ?? const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF162D4A), Color(0xFF132745)],
      ),
      boxShadow: boxShadow,
    );
  }

  /// 创建确认按钮样式
  static NotchButtonStyle confirmButton({
    Color? borderColor,
    Color? innerGlowColor,
    Gradient? gradient,
    List<BoxShadow>? boxShadow,
  }) {
    return NotchButtonStyle(
      borderColor: borderColor ?? const Color(0xFF223650),
      innerGlowColor: innerGlowColor ?? const Color(0x08FFFFFF),
      gradient: gradient ?? const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF10233C), Color(0xFF0D1E34)],
      ),
      boxShadow: boxShadow,
    );
  }
}
