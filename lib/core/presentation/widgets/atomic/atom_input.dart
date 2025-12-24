import 'package:flutter/material.dart';
import '../../../theme/design_tokens.dart';
import '../../../theme/app_colors.dart';

/// 原子化输入框组件
/// 
/// 统一了毛玻璃背景、边框样式和焦点状态
class AtomInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool autoFocus;

  const AtomInput({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autoFocus = false,
  });

  @override
  State<AtomInput> createState() => _AtomInputState();
}

class _AtomInputState extends State<AtomInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DesignTokens.animationDuration,
      decoration: BoxDecoration(
        color: _isFocused ? DesignTokens.black40a : DesignTokens.black30a,
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusXl),
        border: Border.all(
          color: _isFocused ? DesignTokens.primaryColor : DesignTokens.borderColor,
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: DesignTokens.primaryColor.withValues(alpha: 0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ]
            : null,
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        autofocus: widget.autoFocus,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: TextStyle(
          color: DesignTokens.bodyColor,
          fontSize: DesignTokens.fontSizeBase,
          fontFamily: DesignTokens.fontFamily,
        ),
        cursorColor: DesignTokens.primaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: DesignTokens.emphasisColor,
            fontSize: DesignTokens.fontSizeBase,
          ),
          prefixIcon: widget.prefixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: _isFocused ? DesignTokens.primaryColor : DesignTokens.grey50,
                  ),
                  child: widget.prefixIcon!,
                )
              : null,
          suffixIcon: widget.suffixIcon != null
              ? IconTheme(
                  data: IconThemeData(
                    color: _isFocused ? DesignTokens.primaryColor : DesignTokens.grey50,
                  ),
                  child: widget.suffixIcon!,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingMd,
            vertical: DesignTokens.spacingMd,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
