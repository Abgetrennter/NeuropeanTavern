/// 选项按钮组件
/// 
/// 用于决策卡片中的可选项按钮，支持多选、动画效果和状态切换
library;

import 'package:flutter/material.dart';
import 'decision_card_theme.dart';
import 'clip_shapes.dart';

/// 选项按钮
/// 
/// 带切角效果的交互式按钮，支持流光动画和选中状态
class OptionButton extends StatefulWidget {
  /// 按钮文本
  final String text;

  /// 是否选中
  final bool isSelected;

  /// 选项索引（用于显示编号）
  final int index;

  /// 点击回调
  final VoidCallback? onTap;

  /// 是否禁用
  final bool isDisabled;

  /// 启用流光动画
  final bool enableSheenAnimation;

  /// 是否减少动画（无障碍）
  final bool reduceMotion;

  const OptionButton({
    super.key,
    required this.text,
    required this.index,
    this.isSelected = false,
    this.onTap,
    this.isDisabled = false,
    this.enableSheenAnimation = true,
    this.reduceMotion = false,
  });

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _sheenController;
  late Animation<double> _sheenAnimation;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _initSheenAnimation();
  }

  void _initSheenAnimation() {
    if (widget.enableSheenAnimation && !widget.reduceMotion) {
      _sheenController = AnimationController(
        duration: DecisionCardTheme.buttonSheenDuration,
        vsync: this,
      );

      _sheenAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _sheenController,
          curve: Curves.linear,
        ),
      );

      _sheenController.repeat();
    }
  }

  @override
  void didUpdateWidget(OptionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enableSheenAnimation != widget.enableSheenAnimation ||
        oldWidget.reduceMotion != widget.reduceMotion) {
      _sheenController.dispose();
      _initSheenAnimation();
    }
  }

  @override
  void dispose() {
    _sheenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.isDisabled;

    // 确定当前样式
    final currentStyle = _determineButtonStyle();
    final currentShadow = _determineButtonShadow();

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: isDisabled ? null : (_) => setState(() => _isHovered = true),
      onExit: isDisabled ? null : (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
        onTapUp: isDisabled ? null : (_) {
          setState(() => _isPressed = false);
          widget.onTap?.call();
        },
        onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: DecisionCardTheme.hoverAnimationDuration,
          curve: DecisionCardTheme.easeOut,
          transform: Matrix4.translationValues(
            0,
            _isHovered ? -1.0 : 0,
            0,
          ),
          child: _buildButtonContent(currentStyle, currentShadow),
        ),
      ),
    );
  }

  /// 确定按钮样式
  NotchButtonStyle _determineButtonStyle() {
    if (widget.isSelected) {
      return NotchButtonStyle.selectedButton(
        borderColor: DecisionCardTheme.btnBorderActive,
        gradient: DecisionCardTheme.buttonSelectedGradient,
      );
    } else if (_isPressed) {
      return NotchButtonStyle.defaultButton(
        borderColor: DecisionCardTheme.btnBorder,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [DecisionCardTheme.btnActive, DecisionCardTheme.btnActive],
        ),
      );
    } else if (_isHovered) {
      return NotchButtonStyle.defaultButton(
        borderColor: DecisionCardTheme.lineStrong,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [DecisionCardTheme.btnHover, DecisionCardTheme.btnHover],
        ),
      );
    } else {
      return NotchButtonStyle.defaultButton(
        borderColor: DecisionCardTheme.btnBorder,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [DecisionCardTheme.btnBackground, DecisionCardTheme.btnBackground],
        ),
      );
    }
  }

  /// 确定按钮阴影
  List<BoxShadow> _determineButtonShadow() {
    if (widget.isSelected) {
      return DecisionCardTheme.buttonActiveShadow;
    } else if (_isHovered) {
      return DecisionCardTheme.buttonHoverShadow;
    } else {
      return DecisionCardTheme.buttonShadow;
    }
  }

  /// 构建按钮内容
  Widget _buildButtonContent(
    NotchButtonStyle style,
    List<BoxShadow> shadow,
  ) {
    return NotchContainer(
      notchSize: DecisionCardTheme.notchSize,
      gradient: style.gradient,
      borderColor: style.borderColor,
      innerGlowColor: DecisionCardTheme.buttonInnerGlowColor,
      boxShadow: shadow,
      padding: EdgeInsets.symmetric(
        vertical: DecisionCardTheme.buttonPaddingVertical,
        horizontal: 0,
      ),
      child: Stack(
        children: [
          // 流光动画层
          if (widget.enableSheenAnimation && !widget.reduceMotion)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _sheenAnimation,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(_sheenAnimation.value, 0),
                    child: Opacity(
                      opacity: DecisionCardTheme.buttonSheenOpacity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: DecisionCardTheme.buttonSheenGradient,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // 按钮内容
          Padding(
            padding: EdgeInsets.only(
              left: DecisionCardTheme.buttonPaddingLeft,
              right: DecisionCardTheme.buttonPaddingRight,
            ),
            child: Row(
              children: [
                // 选项编号
                Text(
                  '${widget.index}. ',
                  style: TextStyle(
                    fontSize: DecisionCardTheme.buttonFontSize,
                    fontWeight: DecisionCardTheme.buttonFontWeight,
                    color: widget.isSelected
                        ? DecisionCardTheme.textMain
                        : DecisionCardTheme.textMain.withOpacity(
                            _isHovered ? 1.0 : 0.9,
                          ),
                  ),
                ),
                // 按钮文本
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: DecisionCardTheme.buttonFontSize,
                      fontWeight: DecisionCardTheme.buttonFontWeight,
                      color: widget.isSelected
                          ? DecisionCardTheme.textMain
                          : DecisionCardTheme.textMain.withOpacity(
                              _isHovered ? 1.0 : 0.9,
                            ),
                    ),
                  ),
                ),
                // 选中标记
                if (widget.isSelected) _buildSelectionIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建选中标记
  Widget _buildSelectionIndicator() {
    return Container(
      width: DecisionCardTheme.selectionIndicatorSize,
      height: DecisionCardTheme.selectionIndicatorSize,
      margin: EdgeInsets.only(right: DecisionCardTheme.selectionIndicatorRightMargin),
      decoration: BoxDecoration(
        color: DecisionCardTheme.accent,
        borderRadius: BorderRadius.circular(DecisionCardTheme.selectionIndicatorRadius),
        boxShadow: DecisionCardTheme.selectionIndicatorShadow,
      ),
    );
  }
}

/// 选项按钮组
/// 
/// 管理多个选项按钮的布局和交互
class OptionButtonGroup extends StatelessWidget {
  /// 选项列表
  final List<String> options;

  /// 选中的选项索引
  final Set<int> selectedIndices;

  /// 选项点击回调
  final Function(int index, bool isSelected)? onOptionTap;

  /// 是否禁用
  final bool isDisabled;

  /// 启用流光动画
  final bool enableSheenAnimation;

  /// 是否减少动画（无障碍）
  final bool reduceMotion;

  /// 列表最大列数（响应式）
  final int maxColumns;

  const OptionButtonGroup({
    super.key,
    required this.options,
    required this.selectedIndices,
    this.onOptionTap,
    this.isDisabled = false,
    this.enableSheenAnimation = true,
    this.reduceMotion = false,
    this.maxColumns = 2,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // 响应式列数
    final columns = screenWidth >= DecisionCardTheme.desktopBreakpoint ? maxColumns : 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(top: DecisionCardTheme.buttonGroupPaddingTop),
          child: Column(
            children: [
              // 顶部虚线分隔
              Container(
                height: 1,
                margin: EdgeInsets.only(bottom: DecisionCardTheme.buttonGroupGap),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(DecisionCardTheme.topDashedLineOpacity),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // 按钮网格
              _buildButtonGrid(columns),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonGrid(int columns) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: _calculateAspectRatio(columns),
        crossAxisSpacing: DecisionCardTheme.buttonGroupGap,
        mainAxisSpacing: DecisionCardTheme.buttonGroupGap,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return OptionButton(
          text: options[index],
          index: index + 1,
          isSelected: selectedIndices.contains(index),
          isDisabled: isDisabled,
          enableSheenAnimation: enableSheenAnimation,
          reduceMotion: reduceMotion,
          onTap: () {
            final isSelected = selectedIndices.contains(index);
            onOptionTap?.call(index, !isSelected);
          },
        );
      },
    );
  }

  /// 计算按钮宽高比
  double _calculateAspectRatio(int columns) {
    // 基础宽度估算（根据内容长度）
    final maxTextLength = options.map((e) => e.length).reduce((a, b) => a > b ? a : b);
    final estimatedWidth = (maxTextLength + 3) * DecisionCardTheme.buttonFontSize;
    
    // 标准高度
    final estimatedHeight = DecisionCardTheme.buttonPaddingVertical * 2 + DecisionCardTheme.buttonFontSize * 1.5;
    
    return estimatedWidth / estimatedHeight;
  }
}
