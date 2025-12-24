/// Tips面板组件
/// 
/// 用于显示提示信息和确认按钮，支持响应式布局和流动线动画
library;

import 'package:flutter/material.dart';
import 'decision_card_theme.dart';
import 'clip_shapes.dart';
import 'confirm_button_widget.dart';

/// Tips面板
/// 
/// 显示提示文本和确认按钮，支持桌面端环绕模式和移动端吸底模式
class TipsPanel extends StatefulWidget {
  /// 提示文本
  final String? tipsText;

  /// 确认按钮文本
  final String confirmButtonText;

  /// 确认按钮点击回调
  final VoidCallback? onConfirm;

  /// 是否禁用确认按钮
  final bool isConfirmDisabled;

  /// 启用流动线动画
  final bool enableAuroraAnimation;

  /// 是否减少动画（无障碍）
  final bool reduceMotion;

  const TipsPanel({
    super.key,
    this.tipsText,
    this.confirmButtonText = '确认发送',
    this.onConfirm,
    this.isConfirmDisabled = true,
    this.enableAuroraAnimation = true,
    this.reduceMotion = false,
  });

  @override
  State<TipsPanel> createState() => _TipsPanelState();
}

class _TipsPanelState extends State<TipsPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _auroraController;
  late Animation<double> _auroraAnimation;

  @override
  void initState() {
    super.initState();
    _initAuroraAnimation();
  }

  void _initAuroraAnimation() {
    if (widget.enableAuroraAnimation && !widget.reduceMotion) {
      _auroraController = AnimationController(
        duration: DecisionCardTheme.auroraRunDuration,
        vsync: this,
      );

      _auroraAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _auroraController,
          curve: Curves.linear,
        ),
      );

      _auroraController.repeat();
    }
  }

  @override
  void didUpdateWidget(TipsPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enableAuroraAnimation != widget.enableAuroraAnimation ||
        oldWidget.reduceMotion != widget.reduceMotion) {
      _auroraController.dispose();
      _initAuroraAnimation();
    }
  }

  @override
  void dispose() {
    _auroraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= DecisionCardTheme.desktopBreakpoint;

    return Container(
      margin: EdgeInsets.only(top: DecisionCardTheme.tipsPanelMarginTop),
      child: isDesktop
          ? _buildDesktopLayout()
          : _buildMobileLayout(),
    );
  }

  /// 桌面端布局（环绕模式）
  Widget _buildDesktopLayout() {
    return NotchContainer(
      notchSize: DecisionCardTheme.notchSize,
      gradient: DecisionCardTheme.tipsPanelBackground,
      borderColor: DecisionCardTheme.lineWeak,
      innerGlowColor: DecisionCardTheme.tipsPanelInnerGlowColor,
      boxShadow: DecisionCardTheme.tipsPanelShadow,
      padding: EdgeInsets.all(DecisionCardTheme.tipsPanelPadding),
      child: Stack(
        children: [
          // 流动线动画
          if (widget.enableAuroraAnimation && !widget.reduceMotion)
            Positioned(
              left: 10,
              right: 10,
              top: 0,
              height: 1,
              child: AnimatedBuilder(
                animation: _auroraAnimation,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(_auroraAnimation.value, 0),
                    child: Opacity(
                      opacity: DecisionCardTheme.auroraOpacity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: DecisionCardTheme.auroraGradient,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // 内容区域
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 提示文本区域
              Expanded(
                child: _buildTipsContent(),
              ),
              
              // 确认按钮
              Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 6.0),
                child: ConfirmButton(
                  text: widget.confirmButtonText,
                  isDisabled: widget.isConfirmDisabled,
                  onTap: widget.onConfirm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 移动端布局（吸底+居中）
  Widget _buildMobileLayout() {
    return NotchContainer(
      notchSize: DecisionCardTheme.notchSize,
      gradient: DecisionCardTheme.tipsPanelBackground,
      borderColor: DecisionCardTheme.lineWeak,
      innerGlowColor: DecisionCardTheme.tipsPanelInnerGlowColor,
      boxShadow: DecisionCardTheme.tipsPanelShadow,
      padding: EdgeInsets.all(DecisionCardTheme.tipsPanelPadding),
      child: Stack(
        children: [
          // 流动线动画
          if (widget.enableAuroraAnimation && !widget.reduceMotion)
            Positioned(
              left: 10,
              right: 10,
              top: 0,
              height: 1,
              child: AnimatedBuilder(
                animation: _auroraAnimation,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(_auroraAnimation.value, 0),
                    child: Opacity(
                      opacity: DecisionCardTheme.auroraOpacity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: DecisionCardTheme.auroraGradient,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // 内容区域
          Column(
            children: [
              // 提示文本区域
              _buildTipsContent(),
              
              // 确认按钮
              if (widget.tipsText != null && widget.tipsText!.trim().isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: DecisionCardTheme.tipsPanelGap),
                  child: Center(
                    child: ConfirmButton(
                      text: widget.confirmButtonText,
                      isDisabled: widget.isConfirmDisabled,
                      onTap: widget.onConfirm,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建提示内容
  Widget _buildTipsContent() {
    final hasTipsText = widget.tipsText != null && widget.tipsText!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tips标题（仅在有文本时显示）
        if (hasTipsText)
          Text(
            'TIPS',
            style: TextStyle(
              fontSize: DecisionCardTheme.tipsTitleFontSize,
              color: DecisionCardTheme.accent.withOpacity(0.8),
              letterSpacing: DecisionCardTheme.tipsTitleLetterSpacing,
              fontWeight: FontWeight.w600,
            ),
          ),
        
        // Tips内容
        if (hasTipsText)
          Padding(
            padding: EdgeInsets.only(top: DecisionCardTheme.tipsTitleMarginBottom),
            child: Text(
              widget.tipsText!,
              style: TextStyle(
                fontSize: DecisionCardTheme.tipsContentFontSize,
                color: DecisionCardTheme.textDim,
                height: DecisionCardTheme.tipsContentLineHeight,
              ),
            ),
          ),
      ],
    );
  }
}
