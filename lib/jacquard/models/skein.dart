/// Skein（绞纱）- 结构化 Prompt 容器
///
/// Skein 是 Jacquard 流水线中的核心数据对象。
/// 它取代了传统的字符串拼接，模块化地管理各种 Prompt 组件。
///
/// Skein 的优势：
/// - 结构化存储，便于动态裁剪与重组
/// - 支持版本控制与快照
/// - 易于扩展新的 Prompt 组件
/// - 支持多语言和模板系统
///
/// TODO: 实现完整的 Skein 容器
class Skein {
  /// 系统提示词
  final String systemPrompt;

  /// 设定与背景
  final String lore;

  /// 用户输入
  final String userInput;

  /// 当前状态快照
  final Map<String, dynamic> state;

  /// 示例对话
  final List<DialogueEntry> examples;

  /// 扩展数据（用于第三方集成）
  final Map<String, dynamic> extensions;

  const Skein({
    required this.systemPrompt,
    required this.lore,
    required this.userInput,
    required this.state,
    this.examples = const [],
    this.extensions = const {},
  });

  /// 创建空 Skein
  static const Skein empty = Skein(
    systemPrompt: '',
    lore: '',
    userInput: '',
    state: {},
    examples: [],
    extensions: {},
  );

  /// 创建副本
  Skein copyWith({
    String? systemPrompt,
    String? lore,
    String? userInput,
    Map<String, dynamic>? state,
    List<DialogueEntry>? examples,
    Map<String, dynamic>? extensions,
  }) {
    return Skein(
      systemPrompt: systemPrompt ?? this.systemPrompt,
      lore: lore ?? this.lore,
      userInput: userInput ?? this.userInput,
      state: state ?? Map.from(this.state),
      examples: examples ?? List.from(this.examples),
      extensions: extensions ?? Map.from(this.extensions),
    );
  }

  /// 渲染为字符串（占位符实现）
  ///
  /// TODO: 实现完整的渲染逻辑，支持模板和占位符替换
  String render() {
    final buffer = StringBuffer();
    
    if (systemPrompt.isNotEmpty) {
      buffer.writeln(systemPrompt);
      buffer.writeln();
    }
    
    if (lore.isNotEmpty) {
      buffer.writeln(lore);
      buffer.writeln();
    }
    
    if (examples.isNotEmpty) {
      buffer.writeln('Examples:');
      for (final example in examples) {
        buffer.writeln('${example.role}: ${example.content}');
      }
      buffer.writeln();
    }
    
    if (state.isNotEmpty) {
      buffer.writeln('State:');
      state.forEach((key, value) {
        buffer.writeln('  $key: $value');
      });
      buffer.writeln();
    }
    
    buffer.writeln(userInput);
    
    return buffer.toString();
  }

  @override
  String toString() => 'Skein(${render().length} chars)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Skein &&
        other.systemPrompt == systemPrompt &&
        other.lore == lore &&
        other.userInput == userInput &&
        other.state == state;
  }

  @override
  int get hashCode =>
      systemPrompt.hashCode ^
      lore.hashCode ^
      userInput.hashCode ^
      state.hashCode;
}

/// 对话条目
class DialogueEntry {
  final String role;
  final String content;

  const DialogueEntry({
    required this.role,
    required this.content,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DialogueEntry &&
        other.role == role &&
        other.content == content;
  }

  @override
  int get hashCode => role.hashCode ^ content.hashCode;
}
