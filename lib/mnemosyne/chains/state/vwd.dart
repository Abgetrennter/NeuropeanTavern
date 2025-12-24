/// Value with Description（带描述的值）
///
/// VWD 是 Mnemosyne 的核心数据模型，它不仅存储值本身，
/// 还存储值的语义描述，使状态对程序和 LLM 都可理解。
///
/// VWD 的优势：
/// - 对程序：提供清晰的值访问接口
/// - 对 LLM：提供语义化的状态描述
/// - 支持多语言描述
/// - 便于状态文档化和调试
///
/// 示例：
/// ```dart
/// final hp = VWD<int>(
///   value: 80,
///   description: '当前生命值，0 为死亡，100 为满血',
/// );
/// ```
///
/// TODO: 实现完整的 VWD 系统
class VWD<T> {
  /// 实际值
  final T value;

  /// 值的描述（用于 LLM 理解）
  final String description;

  /// 多语言描述（可选）
  final Map<String, String>? descriptions;

  const VWD({
    required this.value,
    required this.description,
    this.descriptions,
  });

  /// 获取指定语言的描述
  String getDescription([String lang = 'zh']) {
    if (descriptions != null && descriptions!.containsKey(lang)) {
      return descriptions![lang]!;
    }
    return description;
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'value': value,
      'description': description,
    };
    
    if (descriptions != null) {
      json['descriptions'] = descriptions;
    }
    
    return json;
  }

  /// 从 JSON 创建
  factory VWD.fromJson(Map<String, dynamic> json) {
    return VWD(
      value: json['value'] as T,
      description: json['description'] as String,
      descriptions: json['descriptions'] as Map<String, String>?,
    );
  }

  /// 创建副本
  VWD<T> copyWith({
    T? value,
    String? description,
    Map<String, String>? descriptions,
  }) {
    return VWD(
      value: value ?? this.value,
      description: description ?? this.description,
      descriptions: descriptions ?? this.descriptions,
    );
  }

  /// 用于渲染到 LLM Prompt 的字符串
  String toPromptString([String lang = 'zh']) {
    return '$value (${getDescription(lang)})';
  }

  @override
  String toString() => 'VWD($value: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VWD<T> &&
        other.value == value &&
        other.description == description;
  }

  @override
  int get hashCode => value.hashCode ^ description.hashCode;
}

/// 状态树中的 VWD 辅助函数
class VWDHelper {
  /// 从 VWD 中提取值
  static T extractValue<T>(dynamic vwd) {
    if (vwd is VWD<T>) {
      return vwd.value;
    }
    return vwd as T;
  }

  /// 从 VWD 中提取描述
  static String extractDescription(dynamic vwd) {
    if (vwd is VWD) {
      return vwd.description;
    }
    return vwd.toString();
  }

  /// 检查是否是 VWD
  static bool isVWD(dynamic value) {
    return value is VWD;
  }

  /// 批量提取值
  static Map<String, dynamic> extractValues(Map<String, dynamic> map) {
    final result = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is VWD) {
        result[key] = value.value;
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  /// 批量提取描述
  static Map<String, String> extractDescriptions(Map<String, dynamic> map) {
    final result = <String, String>{};
    map.forEach((key, value) {
      if (value is VWD) {
        result[key] = value.description;
      }
    });
    return result;
  }
}
