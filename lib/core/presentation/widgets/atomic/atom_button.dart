import 'package:flutter/material.dart';
import '../../../theme/design_tokens.dart';
import '../../../theme/app_colors.dart';

enum AtomButtonVariant {
  primary,
  secondary,
  ghost,
  icon,
  danger,
}

enum AtomButtonSize {
  small,
  medium,
  large,
}

/// 原子化按钮组件
/// 
/// 统一了 Hover 效果、点击反馈和尺寸规范
class AtomButton extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AtomButtonVariant variant;
  final AtomButtonSize size;
  final bool isLoading;
  final String? tooltip;

  const AtomButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.variant = AtomButtonVariant.primary,
    this.size = AtomButtonSize.medium,
    this.isLoading = false,
    this.tooltip,
  });

  @override
  State<AtomButton> createState() => _AtomButtonState();
}

class _AtomButtonState extends State<AtomButton> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: DesignTokens.animationDuration,
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _scaleController.reverse();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      _scaleController.forward();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null) {
      _scaleController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;
    
    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: _getIconSize(),
            height: _getIconSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _getTextColor(isDisabled),
            ),
          ),
          if (widget.label != null) SizedBox(width: DesignTokens.spacingSm),
        ] else if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: _getIconSize(),
            color: _getTextColor(isDisabled),
          ),
          if (widget.label != null) SizedBox(width: DesignTokens.spacingSm),
        ],
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(
              color: _getTextColor(isDisabled),
              fontSize: _getFontSize(),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isDisabled ? null : widget.onPressed,
        onTapDown: isDisabled ? null : _onTapDown,
        onTapUp: isDisabled ? null : _onTapUp,
        onTapCancel: isDisabled ? null : _onTapCancel,
        child: ScaleTransition(
          scale: _scaleController,
          child: AnimatedContainer(
            duration: DesignTokens.animationDuration,
            padding: _getPadding(),
            decoration: BoxDecoration(
              color: _getBackgroundColor(isDisabled),
              borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
              border: _getBorder(isDisabled),
              boxShadow: _isHovered && !isDisabled && widget.variant == AtomButtonVariant.primary
                  ? DesignTokens.elevation2
                  : null,
            ),
            child: buttonContent,
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(
        message: widget.tooltip!,
        child: button,
      );
    }

    return button;
  }

  Color _getBackgroundColor(bool isDisabled) {
    if (isDisabled) return DesignTokens.grey30a;
    
    switch (widget.variant) {
      case AtomButtonVariant.primary:
        return _isHovered ? DesignTokens.primaryColor.withValues(alpha: 0.9) : DesignTokens.primaryColor;
      case AtomButtonVariant.secondary:
        return _isHovered ? DesignTokens.black50a : DesignTokens.black30a;
      case AtomButtonVariant.danger:
        return _isHovered ? AppColors.errorHover : AppColors.errorBg;
      case AtomButtonVariant.ghost:
      case AtomButtonVariant.icon:
        return _isHovered ? DesignTokens.white20a : Colors.transparent;
    }
  }

  Color _getTextColor(bool isDisabled) {
    if (isDisabled) return DesignTokens.grey50;
    
    switch (widget.variant) {
      case AtomButtonVariant.ghost:
      case AtomButtonVariant.icon:
        return _isHovered ? DesignTokens.white100 : DesignTokens.bodyColor;
      default:
        return DesignTokens.white100;
    }
  }

  Border? _getBorder(bool isDisabled) {
    if (widget.variant == AtomButtonVariant.secondary && !isDisabled) {
      return Border.all(
        color: _isHovered ? DesignTokens.primaryColor : DesignTokens.borderColor,
      );
    }
    return null;
  }

  EdgeInsets _getPadding() {
    if (widget.variant == AtomButtonVariant.icon) {
      return EdgeInsets.all(DesignTokens.spacingSm);
    }
    
    switch (widget.size) {
      case AtomButtonSize.small:
        return EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd, vertical: DesignTokens.spacingXs);
      case AtomButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: DesignTokens.spacingLg, vertical: DesignTokens.spacingSm);
      case AtomButtonSize.large:
        return EdgeInsets.symmetric(horizontal: DesignTokens.spacingXl, vertical: DesignTokens.spacingMd);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case AtomButtonSize.small:
        return DesignTokens.fontSizeXs;
      case AtomButtonSize.medium:
        return DesignTokens.fontSizeBase;
      case AtomButtonSize.large:
        return DesignTokens.fontSizeLg;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case AtomButtonSize.small:
        return 16.0;
      case AtomButtonSize.medium:
        return 20.0;
      case AtomButtonSize.large:
        return 24.0;
    }
  }
}
