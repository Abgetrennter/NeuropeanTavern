/// 时间指针
///
/// TimePointer 用于标识多重宇宙树中的特定时间点。
/// 支持回合制和分支管理。
///
/// 每个 TimePoint 由两部分组成：
/// - [turn]: 回合数（从 0 开始）
/// - [branch]: 分支索引（0 表示主分支，>0 表示其他分支）
///
/// 示例：
/// - TimePointer(turn: 0) - 初始状态
/// - TimePointer(turn: 5) - 第 5 回合
/// - TimePointer(turn: 5, branch: 1) - 第 5 回合的第 1 个分支
class TimePointer {
  final int turn;
  final int branch;

  const TimePointer({
    required this.turn,
    this.branch = 0,
  });

  /// 获取当前时间点（初始状态）
  static const TimePointer current = TimePointer(turn: 0);

  /// 获取下一个回合的时间点
  TimePointer nextTurn() {
    return TimePointer(turn: turn + 1, branch: 0);
  }

  /// 获取下一个分支的时间点
  TimePointer nextBranch() {
    return TimePointer(turn: turn, branch: branch + 1);
  }

  /// 获取父节点的时间点（上一个回合）
  TimePointer? get parent {
    if (turn == 0) return null;
    return TimePointer(turn: turn - 1, branch: 0);
  }

  /// 判断是否是主分支
  bool get isMainBranch => branch == 0;

  /// 比较两个时间点
  bool isBefore(TimePointer other) {
    if (turn != other.turn) {
      return turn < other.turn;
    }
    return branch < other.branch;
  }

  /// 转换为字符串表示
  @override
  String toString() => 'T${turn}${branch > 0 ? 'B$branch' : ''}';

  /// 转换为键（用于存储）
  String toKey() => '${turn}_${branch}';

  /// 从键创建 TimePointer
  static TimePointer fromKey(String key) {
    final parts = key.split('_');
    if (parts.length != 2) {
      throw ArgumentError('Invalid TimePointer key: $key');
    }
    return TimePointer(
      turn: int.parse(parts[0]),
      branch: int.parse(parts[1]),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimePointer &&
        other.turn == turn &&
        other.branch == branch;
  }

  @override
  int get hashCode => turn.hashCode ^ branch.hashCode;
}
