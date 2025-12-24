# 决策卡片组件库

> 像素级还原1.html中的卡片UI设计

## 📋 概述

这是一套高质量的Flutter决策卡片组件库，完全基于1.html中的视觉规范进行像素级还原。组件支持多选决策、优雅的动画效果、响应式布局，并遵循Dart最佳实践。

## ✨ 特性

- ✅ **像素级还原**：精确还原1.html中的所有视觉细节
- 🎨 **完整设计系统**：统一的设计令牌管理配色、间距、字体
- 🎬 **优雅动效**：呼吸光效、流光动画、流动线等
- 📱 **响应式布局**：桌面端环绕模式、移动端吸底模式
- ♿ **无障碍支持**：支持减少动画选项
- 🔧 **高度可配置**：所有参数均可自定义
- 📦 **切角设计**：独特的10px切角视觉效果

## 📁 文件结构

```
design/decision_card/
├── decision_card_theme.dart          # 设计令牌（颜色、间距、字体等）
├── clip_shapes.dart                 # 切角形状定义
├── card_animation_controller.dart    # 动画控制器
├── option_button_widget.dart        # 选项按钮组件
├── confirm_button_widget.dart        # 确认按钮组件
├── tips_panel_widget.dart           # Tips面板组件
├── decision_card_widget.dart         # 主卡片组件
└── README.md                      # 使用说明（本文件）
```

## 🚀 快速开始

### 基础使用

```dart
import 'package:flutter/material.dart';
import 'design/decision_card/decision_card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF171717),
        body: const Center(
          child: DecisionCard(
            title: '选择您的偏好',
            subtitle: 'GrayWill · Decision',
            options: [
              '选项一：这是第一个选项',
              '选项二：这是第二个选项',
              '选项三：这是第三个选项',
              '选项四：这是第四个选项',
            ],
            tipsText: '这是一个提示文本，用于说明当前决策的上下文信息。',
            confirmButtonText: '确认发送',
          ),
        ),
      ),
    );
  }
}
```

### 完整示例

```dart
class FullExample extends StatefulWidget {
  const FullExample({super.key});

  @override
  State<FullExample> createState() => _FullExampleState();
}

class _FullExampleState extends State<FullExample> {
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: Center(
        child: DecisionCard(
          title: '决策标题',
          subtitle: 'GrayWill · Decision',
          options: [
            '选项一：这是一个描述性文本',
            '选项二：另一个选择',
            '选项三：第三个选项',
            '选项四：最后的选项',
          ],
          tipsText: '这是一个提示文本，用于说明当前决策的上下文信息。您可以点击多个选项进行多选。',
          confirmButtonText: '确认发送',
          initiallyExpanded: true,
          isDisabled: false,
          enableCardGlow: true,
          enableButtonSheen: true,
          enableAuroraAnimation: true,
          reduceMotion: false,
          onOptionTap: (index, isSelected) {
            setState(() {
              if (isSelected) {
                _selectedIndices.add(index);
              } else {
                _selectedIndices.remove(index);
              }
            });
          },
          onConfirm: () {
            // 获取选中的选项文本
            final selectedOptions = widget.options
                .asMap()
                .entries
                .where((entry) => _selectedIndices.contains(entry.key))
                .map((entry) => entry.value)
                .toList();
            
            final message = selectedOptions.join(' ');
            
            // 显示确认信息
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('已确认发送: $message'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          onToggle: (isExpanded) {
            debugPrint('卡片 ${isExpanded ? "已展开" : "已收起"}');
          },
        ),
      ),
    );
  }
}
```

## 📖 组件文档

### DecisionCard

主决策卡片组件。

#### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|----------|------|
| `title` | `String` | **必需** | 卡片标题 |
| `subtitle` | `String?` | `null` | 副标题（作者/决策类型） |
| `options` | `List<String>` | **必需** | 选项列表 |
| `tipsText` | `String?` | `null` | 提示文本 |
| `confirmButtonText` | `String` | `'确认发送'` | 确认按钮文本 |
| `initiallyExpanded` | `bool` | `true` | 初始是否展开 |
| `onOptionTap` | `Function(int, bool)?` | `null` | 选项点击回调 |
| `onConfirm` | `VoidCallback?` | `null` | 确认按钮点击回调 |
| `onToggle` | `Function(bool)?` | `null` | 展开/收起切换回调 |
| `isDisabled` | `bool` | `false` | 是否禁用整个卡片 |
| `enableCardGlow` | `bool` | `true` | 启用卡片呼吸光效 |
| `enableButtonSheen` | `bool` | `true` | 启用按钮流光动画 |
| `enableAuroraAnimation` | `bool` | `true` | 启用Tips流动线动画 |
| `reduceMotion` | `bool` | `false` | 减少动画（无障碍） |

### OptionButton

选项按钮组件，支持多选和流光动画。

#### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|----------|------|
| `text` | `String` | **必需** | 按钮文本 |
| `index` | `int` | **必需** | 选项索引（用于显示编号） |
| `isSelected` | `bool` | `false` | 是否选中 |
| `onTap` | `VoidCallback?` | `null` | 点击回调 |
| `isDisabled` | `bool` | `false` | 是否禁用 |
| `enableSheenAnimation` | `bool` | `true` | 启用流光动画 |
| `reduceMotion` | `bool` | `false` | 减少动画 |

### OptionButtonGroup

选项按钮组，管理多个选项按钮的布局和交互。

#### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|----------|------|
| `options` | `List<String>` | **必需** | 选项列表 |
| `selectedIndices` | `Set<int>` | **必需** | 选中的选项索引 |
| `onOptionTap` | `Function(int, bool)?` | `null` | 选项点击回调 |
| `isDisabled` | `bool` | `false` | 是否禁用 |
| `enableSheenAnimation` | `bool` | `true` | 启用流光动画 |
| `reduceMotion` | `bool` | `false` | 减少动画 |
| `maxColumns` | `int` | `2` | 最大列数（响应式） |

### TipsPanel

Tips面板，显示提示信息和确认按钮。

#### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|----------|------|
| `tipsText` | `String?` | `null` | 提示文本 |
| `confirmButtonText` | `String` | `'确认发送'` | 确认按钮文本 |
| `onConfirm` | `VoidCallback?` | `null` | 确认按钮点击回调 |
| `isConfirmDisabled` | `bool` | `true` | 是否禁用确认按钮 |
| `enableAuroraAnimation` | `bool` | `true` | 启用流动线动画 |
| `reduceMotion` | `bool` | `false` | 减少动画 |

### ConfirmButton

确认按钮组件，支持悬停、激活和禁用状态。

#### 参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|----------|------|
| `text` | `String` | **必需** | 按钮文本 |
| `isDisabled` | `bool` | `true` | 是否禁用 |
| `onTap` | `VoidCallback?` | `null` | 点击回调 |
| `minWidth` | `double?` | `null` | 最小宽度 |

## 🎨 设计令牌

`DecisionCardTheme` 类提供了所有视觉设计参数，包括：

### 颜色系统

- `bgDeep` - 主背景渐变
- `btnBackground` / `btnHover` / `btnActive` - 按钮背景色
- `textMain` / `textDim` - 文字颜色
- `accent` / `accentSoft` / `accentFaint` - 强调色

### 间距系统

- `cardPaddingHorizontal` / `cardPaddingBottom` - 卡片内边距
- `buttonPaddingVertical` / `buttonPaddingLeft` / `buttonPaddingRight` - 按钮内边距
- `notchSize` - 切角大小（10px）

### 字体系统

- `titleFontSize` (13px) / `titleFontWeight` (600)
- `subtitleFontSize` (11px)
- `buttonFontSize` (12.5px) / `buttonFontWeight` (500)

### 阴影系统

- `cardShadow` - 卡片阴影
- `buttonShadow` / `buttonHoverShadow` / `buttonActiveShadow` - 按钮阴影
- `confirmButtonShadow` / `confirmButtonHoverShadow` - 确认按钮阴影

### 动画系统

- `cardGlowDuration` (12s) - 卡片呼吸动画时长
- `buttonSheenDuration` (9s) - 按钮流光动画时长
- `auroraRunDuration` (7.8s) - 顶部流动线动画时长
- `selectionAnimationDuration` (180ms) - 选中动画时长

### 响应式断点

- `desktopBreakpoint` (880px) - 桌面端最小宽度

## 🎬 动画效果

### 卡片呼吸光效
- **时长**：12秒循环
- **效果**：顶部柔光渐变，opacity 0.25-0.38
- **启用**：`enableCardGlow`

### 按钮流光动画
- **时长**：9秒线性循环
- **效果**：从左到右的白色流光
- **启用**：`enableButtonSheen`

### 顶部流动线
- **时长**：7.8秒线性循环
- **效果**：蓝色渐变流动线
- **启用**：`enableAuroraAnimation`

### 选中态微动效
- **时长**：180ms
- **效果**：内发光渐变 + 阴影变化

## 📱 响应式设计

### 桌面端（≥880px）
- **选项布局**：2列网格
- **Tips面板**：环绕模式（按钮在右侧）

### 移动端（<880px）
- **选项布局**：单列
- **Tips面板**：吸底居中模式

## ♿ 无障碍

支持系统级减少动画设置：

```dart
// 检查系统减少动画设置
final reduceMotion = MediaQuery.of(context)
    .disableAnimations;

// 应用到组件
DecisionCard(
  reduceMotion: reduceMotion,
  // ...
)
```

## 🔧 自定义

### 自定义颜色

```dart
// 创建自定义主题
class CustomCardTheme extends DecisionCardTheme {
  static const Color customAccent = Color(0xFF00FF88);
  // ... 覆盖其他颜色
}
```

### 自定义尺寸

```dart
DecisionCard(
  // 在父容器中控制尺寸
  Container(
    width: 600,
    height: 800,
    child: DecisionCard(...),
  ),
)
```

### 禁用动画

```dart
DecisionCard(
  enableCardGlow: false,
  enableButtonSheen: false,
  enableAuroraAnimation: false,
  // ...
)
```

## 📊 最佳实践

1. **状态管理**：使用`Set<int>`管理选中状态
2. **回调处理**：在回调中更新状态并触发UI刷新
3. **错误处理**：添加适当的错误边界和用户反馈
4. **性能优化**：使用`const`构造函数减少重建
5. **测试覆盖**：为所有交互路径编写测试

## 🐛 常见问题

### Q: 如何禁用确认按钮？
A: 监听选项选择状态，当没有选中选项时设置`isConfirmDisabled: true`

### Q: 如何获取选中的选项文本？
A: 使用选中的索引从options列表中获取：
```dart
final selectedOptions = options
    .asMap()
    .entries
    .where((entry) => selectedIndices.contains(entry.key))
    .map((entry) => entry.value)
    .toList();
```

### Q: 如何自定义动画时长？
A: 修改`DecisionCardTheme`中的相关时长常量

### Q: 如何在列表中使用？
A: 使用`ListView.builder`或`SingleChildScrollView`包裹

## 📄 许可证

本组件库基于1.html的设计规范进行像素级还原，遵循MIT许可证。

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📞 预览

![示例预览](https://via.placeholder.com/600x400?text=Decision+Card+Preview)

---

**创建日期**：2025年12月25日  
**版本**：1.0.0  
**Flutter版本**：3.0.0+
