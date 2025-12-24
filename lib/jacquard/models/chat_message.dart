/// 聊天消息实体
///
/// ChatMessage 是 Jacquard 层的消息模型，包含消息内容、角色和时间戳。
/// 支持关联状态快照，用于实现回溯和分支功能。
///
/// TODO: 集成 Mnemosyne 的 TimePointer
class ChatMessage {
  /// 消息唯一标识
  final String id;

  /// 消息内容
  final String content;

  /// 角色（user、assistant、system）
  final String role;

  /// 时间戳
  final DateTime timestamp;

  /// 关联的状态快照（可选）
  final Map<String, dynamic>? stateSnapshot;

  /// 时间指针（用于分支和回溯）
  final int? turn;

  /// 分支索引
  final int? branch;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.stateSnapshot,
    this.turn,
    this.branch,
  });

  /// 创建用户消息
  factory ChatMessage.user({
    required String content,
    DateTime? timestamp,
    Map<String, dynamic>? stateSnapshot,
    int? turn,
    int? branch,
  }) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: 'user',
      timestamp: timestamp ?? DateTime.now(),
      stateSnapshot: stateSnapshot,
      turn: turn,
      branch: branch,
    );
  }

  /// 创建助手消息
  factory ChatMessage.assistant({
    required String content,
    DateTime? timestamp,
    Map<String, dynamic>? stateSnapshot,
    int? turn,
    int? branch,
  }) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: 'assistant',
      timestamp: timestamp ?? DateTime.now(),
      stateSnapshot: stateSnapshot,
      turn: turn,
      branch: branch,
    );
  }

  /// 创建系统消息
  factory ChatMessage.system({
    required String content,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: 'system',
      timestamp: timestamp ?? DateTime.now(),
    );
  }

  /// 创建副本
  ChatMessage copyWith({
    String? id,
    String? content,
    String? role,
    DateTime? timestamp,
    Map<String, dynamic>? stateSnapshot,
    int? turn,
    int? branch,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      stateSnapshot: stateSnapshot ?? this.stateSnapshot,
      turn: turn ?? this.turn,
      branch: branch ?? this.branch,
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'role': role,
      'timestamp': timestamp.toIso8601String(),
      if (stateSnapshot != null) 'stateSnapshot': stateSnapshot,
      if (turn != null) 'turn': turn,
      if (branch != null) 'branch': branch,
    };
  }

  /// 从 JSON 创建
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      role: json['role'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      stateSnapshot: json['stateSnapshot'] as Map<String, dynamic>?,
      turn: json['turn'] as int?,
      branch: json['branch'] as int?,
    );
  }

  /// 判断是否是用户消息
  bool get isUser => role == 'user';

  /// 判断是否是助手消息
  bool get isAssistant => role == 'assistant';

  /// 判断是否是系统消息
  bool get isSystem => role == 'system';

  @override
  String toString() => 'ChatMessage($role: ${content.substring(0, 20)}...)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage &&
        other.id == id &&
        other.content == content &&
        other.role == role &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      content.hashCode ^
      role.hashCode ^
      timestamp.hashCode;
}
