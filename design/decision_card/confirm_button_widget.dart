/// 确认按钮组件
/// 
/// 用于Tips面板的确认按钮，支持悬停、激活和禁用状态
library;

import 'package:flutter/material.dart';
import 'decision_card_theme.dart';
import 'clip_shapes.dart';

/// 确认按钮
/// 
/// 带切角效果的确认按钮，支持多种状态样式
class ConfirmButton extends StatefulWidget {
  /// 按钮文本
  final String text;

  /// 是否禁用
  final bool isDisabled;

  /// 点击回调
  final VoidCallback? onTap;

  /// 最小宽度
  final double? minWidth;

  const ConfirmButton({
    super.key,
    required this.text,
    this.isDisabled = true,
    this.onTap,
    this.minWidth,
  });

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: widget.isDisabled
          ? null
          : (_) => setState(() => _isHovered = true),
      onExit: widget.isDisabled
          ? null
          : (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: widget.isDisabled
            ? null
            : (_) => setState(() => _isPressed = true),
        onTapUp: widget.isDisabled
            ? null
            : (_) {
                setState(() => _isPressed = false);
                widget.onTap?.call();
              },
        onTapCancel: widget.isDisabled
            ? null
            : () => setState(() => _isPressed = false),
        child: AnimatedOpacity(
          duration: DecisionCardTheme.hoverAnimationDuration,
          curve: DecisionCardTheme.easeOut,
          opacity: widget.isDisabled 
              ? DecisionCardTheme.confirmButtonDisabledOpacity 
              : 1.0,
          child: AnimatedContainer(
            duration: DecisionCardTheme.hoverAnimationDuration,
            curve: DecisionCardTheme.easeOut,
            transform: Matrix4.translationValues(
              0,
              _isHovered && !widget.isDisabled ? -1.0 : 0,
              0,
            ),
            child: _buildButtonContent(),
          ),
        ),
      ),
    );
  }

  /// 构建按钮内容
  Widget _buildButtonContent() {
    final currentGradient = _determineGradient();
    final currentShadow = _determineShadow();
    final currentBorderColor = _determineBorderColor();
    final currentInnerGlowColor = _determineInnerGlowColor();

    return Container(
      constraints: BoxConstraints(
        minWidth: widget.minWidth ?? DecisionCardTheme.buttonMinWidth,
      ),
      child: NotchContainer(
        notchSize: DecisionCardTheme.notchSize,
        gradient: currentGradient,
        borderColor: currentBorderColor,
        innerGlowColor: currentInnerGlowColor,
        boxShadow: currentShadow,
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 按钮文本
            Text(
              widget.text,
              style: TextStyle(
                fontSize: DecisionCardTheme.confirmButtonFontSize,
                fontWeight: DecisionCardTheme.confirmButtonFontWeight,
                letterSpacing: DecisionCardTheme.confirmButtonLetterSpacing,
                color: DecisionCardTheme.textMain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 确定背景渐变
  LinearGradient _determineGradient() {
    if (widget.isDisabled) {
      return DecisionCardTheme.confirmButtonGradient;
    } else if (_isPressed) {
      return DecisionCardTheme.confirmButtonActiveGradient;
    } else if (_isHovered) {
      return DecisionCardTheme.confirmButtonHoverGradient;
    } else {
      return DecisionCardTheme.confirmButtonGradient;
    }
  }

  /// 确定阴影
  List<BoxShadow> _determineShadow() {
    if (widget.isDisabled) {
      return DecisionCardTheme.confirmButtonDisabledShadow;
    } else if (_isHovered) {
      return DecisionCardTheme.confirmButtonHoverShadow;
    } else {
      return DecisionCardTheme.confirmButtonShadow;
    }
  }

  /// 确定边框颜色
  Color _determineBorderColor() {
    if (widget.isDisabled) {
      return DecisionCardTheme.btnBorder;
    } else if (_isHovered) {
      return DecisionCardTheme.accentSoft;
    } else {
      return DecisionCardTheme.btnBorder;
    }
  }

  /// 确定内高光颜色
  Color? _determineInnerGlowColor() {
    if (widget.isDisabled) {
      return DecisionCardTheme.confirmButtonDisabledInnerGlowColor;
    } else if (_isHovered) {
      return DecisionCardTheme.confirmButtonHoverInnerGlowColor;
    } else {
      return DecisionCardTheme.confirmButtonInnerGlowColor;
    }
  }
}
