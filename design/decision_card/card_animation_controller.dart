/// 卡片动画控制器
/// 
/// 提供统一的动画管理，包括呼吸光效、流动线等动效
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'decision_card_theme.dart';

/// 卡片动画状态
enum CardAnimationState {
  /// 正常状态
  normal,
  
  /// 选中状态
  selected,
  
  /// 禁用状态
  disabled,
  
  /// 淡出状态
  fadingOut,
}

/// 卡片动画控制器
/// 
/// 管理卡片的呼吸光效、流动线等动画
class CardAnimationController extends ChangeNotifier {
  /// 当前动画状态
  CardAnimationState _animationState = CardAnimationState.normal;

  /// 是否启用动画
  bool _animationEnabled = true;

  /// 是否减少动画（无障碍）
  bool _reduceMotion = false;

  /// 流光动画控制器
  AnimationController? _sheenController;

  /// 呼吸光效动画控制器
  AnimationController? _glowController;

  /// 流动线动画控制器
  AnimationController? _auroraController;

  /// 流光动画值
  Animation<double>? _sheenAnimation;

  /// 呼吸光效动画值
  Animation<double>? _glowAnimation;

  /// 流动线动画值
  Animation<double>? _auroraAnimation;

  /// Ticker提供者
  TickerProvider? _tickerProvider;

  /// 当前动画状态
  CardAnimationState get animationState => _animationState;

  /// 是否启用动画
  bool get animationEnabled => _animationEnabled;

  /// 是否减少动画
  bool get reduceMotion => _reduceMotion;

  /// 流光动画值
  Animation<double>? get sheenAnimation => _sheenAnimation;

  /// 呼吸光效动画值
  Animation<double>? get glowAnimation => _glowAnimation;

  /// 流动线动画值
  Animation<double>? get auroraAnimation => _auroraAnimation;

  CardAnimationController();

  /// 初始化动画控制器
  void init(TickerProvider tickerProvider) {
    _tickerProvider = tickerProvider;
    _initAnimations();
  }

  /// 初始化所有动画
  void _initAnimations() {
    if (_tickerProvider == null) return;

    // 流光动画
    if (_animationEnabled && !_reduceMotion) {
      _sheenController = AnimationController(
        duration: DecisionCardTheme.buttonSheenDuration,
        vsync: _tickerProvider!,
      );

      _sheenAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _sheenController!,
          curve: Curves.linear,
        ),
      );

      _sheenController!.repeat();
    }

    // 呼吸光效
    if (_animationEnabled && !_reduceMotion) {
      _glowController = AnimationController(
        duration: DecisionCardTheme.cardGlowDuration,
        vsync: _tickerProvider!,
      );

      _glowAnimation = Tween<double>(
        begin: DecisionCardTheme.cardGlowMinOpacity,
        end: DecisionCardTheme.cardGlowMaxOpacity,
      ).animate(
        CurvedAnimation(
          parent: _glowController!,
          curve: Curves.easeInOut,
        ),
      );

      _glowController!.repeat(reverse: true);
    }

    // 流动线动画
    if (_animationEnabled && !_reduceMotion) {
      _auroraController = AnimationController(
        duration: DecisionCardTheme.auroraRunDuration,
        vsync: _tickerProvider!,
      );

      _auroraAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _auroraController!,
          curve: Curves.linear,
        ),
      );

      _auroraController!.repeat();
    }
  }

  /// 设置动画状态
  void setAnimationState(CardAnimationState state) {
    if (_animationState != state) {
      _animationState = state;
      notifyListeners();
    }
  }

  /// 启用动画
  void enableAnimation() {
    if (!_animationEnabled) {
      _animationEnabled = true;
      _restartAnimations();
      notifyListeners();
    }
  }

  /// 禁用动画
  void disableAnimation() {
    if (_animationEnabled) {
      _animationEnabled = false;
      _disposeAnimations();
      notifyListeners();
    }
  }

  /// 设置减少动画（无障碍）
  void setReduceMotion(bool reduce) {
    if (_reduceMotion != reduce) {
      _reduceMotion = reduce;
      _restartAnimations();
      notifyListeners();
    }
  }

  /// 重启动画
  void _restartAnimations() {
    _disposeAnimations();
    _initAnimations();
  }

  /// 释放动画资源
  void _disposeAnimations() {
    _sheenController?.dispose();
    _sheenController = null;
    _sheenAnimation = null;

    _glowController?.dispose();
    _glowController = null;
    _glowAnimation = null;

    _auroraController?.dispose();
    _auroraController = null;
    _auroraAnimation = null;
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }
}

/// 卡片动画混入
/// 
/// 为Widget提供动画控制能力
mixin CardAnimationMixin<T extends StatefulWidget> on State<T> {
  /// 动画控制器
  late CardAnimationController animationController;

  /// 初始化动画控制器
  void initAnimationController() {
    animationController = CardAnimationController();
    animationController.init(this as TickerProvider);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

/// 呼吸光效组件
/// 
/// 显示卡片的呼吸光效动画
class CardGlowEffect extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 启用动画
  final bool enabled;

  /// 减少动画
  final bool reduceMotion;

  const CardGlowEffect({
    super.key,
    required this.child,
    this.enabled = true,
    this.reduceMotion = false,
  });

  @override
  State<CardGlowEffect> createState() => _CardGlowEffectState();
}

class _CardGlowEffectState extends State<CardGlowEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    if (widget.enabled && !widget.reduceMotion) {
      _controller = AnimationController(
        duration: DecisionCardTheme.cardGlowDuration,
        vsync: this,
      );

      _animation = Tween<double>(
        begin: DecisionCardTheme.cardGlowMinOpacity,
        end: DecisionCardTheme.cardGlowMaxOpacity,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );

      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(CardGlowEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled ||
        oldWidget.reduceMotion != widget.reduceMotion) {
      _controller.dispose();
      _initAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 呼吸光效层
        if (widget.enabled && !widget.reduceMotion)
          Positioned.fill(
            top: -1,
            left: -1,
            right: -1,
            bottom: null,
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: DecisionCardTheme.cardGlowGradient,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        
        // 子组件
        widget.child,
      ],
    );
  }
}
