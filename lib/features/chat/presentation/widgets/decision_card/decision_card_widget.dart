/// 决策卡片主组件
/// 
/// 完整的决策卡片实现，支持选项选择、提示显示和确认操作
library;

import 'package:flutter/material.dart';
import 'decision_card_theme.dart';
import 'clip_shapes.dart';
import 'option_button_widget.dart';
import 'tips_panel_widget.dart';
import 'card_animation_controller.dart';

/// 决策卡片
/// 
/// 提供完整的决策交互体验，包括标题、选项、提示和确认按钮
class DecisionCard extends StatefulWidget {
  /// 卡片标题
  final String title;

  /// 副标题（作者/决策类型）
  final String? subtitle;

  /// 选项列表
  final List<String> options;

  /// 提示文本
  final String? tipsText;

  /// 确认按钮文本
  final String confirmButtonText;

  /// 初始是否展开
  final bool initiallyExpanded;

  /// 选项点击回调
  final Function(int index, bool isSelected)? onOptionTap;

  /// 确认按钮点击回调
  final VoidCallback? onConfirm;

  /// 切换状态回调
  final Function(bool isExpanded)? onToggle;

  /// 是否禁用
  final bool isDisabled;

  /// 启用卡片呼吸光效
  final bool enableCardGlow;

  /// 启用按钮流光动画
  final bool enableButtonSheen;

  /// 启用Tips流动线动画
  final bool enableAuroraAnimation;

  /// 是否减少动画（无障碍）
  final bool reduceMotion;

  const DecisionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.options,
    this.tipsText,
    this.confirmButtonText = '确认发送',
    this.initiallyExpanded = true,
    this.onOptionTap,
    this.onConfirm,
    this.onToggle,
    this.isDisabled = false,
    this.enableCardGlow = true,
    this.enableButtonSheen = true,
    this.enableAuroraAnimation = true,
    this.reduceMotion = false,
  });

  @override
  State<DecisionCard> createState() => _DecisionCardState();
}

class _DecisionCardState extends State<DecisionCard>
    with SingleTickerProviderStateMixin {
  /// 是否展开
  bool _isExpanded = false;

  /// 选中的选项索引
  final Set<int> _selectedIndices = {};

  /// 是否正在淡出
  bool _isFadingOut = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(DecisionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded &&
        _isExpanded != widget.initiallyExpanded) {
      _isExpanded = widget.initiallyExpanded;
    }
  }

  /// 处理选项点击
  void _handleOptionTap(int index, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedIndices.add(index);
      } else {
        _selectedIndices.remove(index);
      }
    });
    widget.onOptionTap?.call(index, isSelected);
  }

  /// 处理确认点击
  void _handleConfirm() {
    if (_selectedIndices.isEmpty) return;
    
    widget.onConfirm?.call();
    
    // 淡出动画
    if (mounted) {
      setState(() => _isFadingOut = true);
      Future.delayed(const Duration(milliseconds: 260), () {
        if (mounted) {
          setState(() => _isFadingOut = false);
        }
      });
    }
  }

  /// 切换展开/收起状态
  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onToggle?.call(_isExpanded);
  }

  /// 确认按钮是否禁用
  bool get _isConfirmDisabled {
    return _selectedIndices.isEmpty || widget.isDisabled;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return _isFadingOut
        ? const SizedBox.shrink()
        : Center(
            child: Container(
              width: screenWidth > DecisionCardTheme.cardMaxWidth
                  ? DecisionCardTheme.cardMaxWidth
                  : double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: CardGlowEffect(
                enabled: widget.enableCardGlow,
                reduceMotion: widget.reduceMotion,
                child: _buildCardContainer(),
              ),
            ),
          );
  }

  /// 构建卡片容器
  Widget _buildCardContainer() {
    return NotchContainer(
      notchSize: DecisionCardTheme.notchSize,
      gradient: DecisionCardTheme.bgDeep,
      borderColor: DecisionCardTheme.lineWeak,
      innerGlowColor: DecisionCardTheme.cardInnerGlowColor,
      boxShadow: DecisionCardTheme.cardShadow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 卡片头部
          _buildCardHeader(),
          
          // 卡片内容区域
          if (_isExpanded)
            _buildCardBody(),
        ],
      ),
    );
  }

  /// 构建卡片头部
  Widget _buildCardHeader() {
    return InkWell(
      onTap: widget.isDisabled ? null : _toggleExpansion,
      child: Container(
        padding: EdgeInsets.all(DecisionCardTheme.headerPadding),
        decoration: BoxDecoration(
          gradient: DecisionCardTheme.cardHeaderBackground,
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.04),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // 标题区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: DecisionCardTheme.titleFontSize,
                      fontWeight: DecisionCardTheme.titleFontWeight,
                      letterSpacing: DecisionCardTheme.titleLetterSpacing,
                      color: DecisionCardTheme.textMain,
                    ),
                  ),
                  // 副标题
                  if (widget.subtitle != null)
                    Padding(
                      padding: EdgeInsets.only(top: DecisionCardTheme.subtitleMarginTop),
                      child: Text(
                        widget.subtitle!,
                        style: TextStyle(
                          fontSize: DecisionCardTheme.subtitleFontSize,
                          color: DecisionCardTheme.textDim
                              .withOpacity(DecisionCardTheme.textDimOpacity),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // 切换文字
            Opacity(
              opacity: _isExpanded ? 1.0 : DecisionCardTheme.toggleTextOpacity,
              child: Text(
                _isExpanded ? '收起' : '展开',
                style: TextStyle(
                  fontSize: DecisionCardTheme.toggleTextFontSize,
                  color: _isExpanded 
                      ? DecisionCardTheme.accent 
                      : DecisionCardTheme.textDim,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建卡片主体内容
  Widget _buildCardBody() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DecisionCardTheme.cardPaddingHorizontal,
      ).copyWith(bottom: DecisionCardTheme.cardPaddingBottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 选项按钮组
          if (widget.options.isNotEmpty)
            OptionButtonGroup(
              options: widget.options,
              selectedIndices: _selectedIndices,
              onOptionTap: widget.isDisabled ? null : _handleOptionTap,
              isDisabled: widget.isDisabled,
              enableSheenAnimation: widget.enableButtonSheen,
              reduceMotion: widget.reduceMotion,
            ),
          
          // Tips面板
          TipsPanel(
            tipsText: widget.tipsText,
            confirmButtonText: widget.confirmButtonText,
            onConfirm: widget.isDisabled ? null : _handleConfirm,
            isConfirmDisabled: _isConfirmDisabled,
            enableAuroraAnimation: widget.enableAuroraAnimation,
            reduceMotion: widget.reduceMotion,
          ),
        ],
      ),
    );
  }
}
