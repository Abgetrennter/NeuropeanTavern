import 'dart:ui';
import 'package:flutter/material.dart';

/// 毛玻璃效果组件
/// 封装了 BackdropFilter 和 Container，用于实现磨砂玻璃视觉效果
class FrostedGlass extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color color;
  final double? borderRadius;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const FrostedGlass({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.color = const Color(0x1AFFFFFF), // Default to slight white tint
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              border: border,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
