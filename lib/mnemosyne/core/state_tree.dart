/// 状态树接口
///
/// StateTree 是 Mnemosyne 的核心抽象，提供对世界状态的读写访问。
/// 支持点路径访问（如 "character.hp"、"inventory.gold"）。
///
/// TODO: 实现 StateTree 的具体实现类
abstract class StateTree {
  /// 获取状态值
  ///
  /// [path] 使用点分隔的路径，如 "character.hp"
  /// 返回该路径对应的值，如果不存在则返回 null
  dynamic get(String path);

  /// 设置状态值
  ///
  /// [path] 使用点分隔的路径，如 "character.hp"
  /// [value] 要设置的值
  void set(String path, dynamic value);

  /// 创建当前状态的快照
  ///
  /// 返回状态的不可变副本
  Map<String, dynamic> createSnapshot();

  /// 从快照恢复状态
  ///
  /// [snapshot] 之前创建的状态快照
  void restoreFromSnapshot(Map<String, dynamic> snapshot);

  /// 检查路径是否存在
  bool has(String path);

  /// 删除路径
  void delete(String path);

  /// 获取所有键
  List<String> getKeys();
}

/// 内存中的 StateTree 实现
///
/// 用于开发和测试的简单实现，未来可替换为持久化实现
class InMemoryStateTree implements StateTree {
  final Map<String, dynamic> _data = {};

  @override
  dynamic get(String path) {
    return _data[path];
  }

  @override
  void set(String path, dynamic value) {
    _data[path] = value;
  }

  @override
  Map<String, dynamic> createSnapshot() {
    return Map<String, dynamic>.from(_data);
  }

  @override
  void restoreFromSnapshot(Map<String, dynamic> snapshot) {
    _data.clear();
    _data.addAll(snapshot);
  }

  @override
  bool has(String path) {
    return _data.containsKey(path);
  }

  @override
  void delete(String path) {
    _data.remove(path);
  }

  @override
  List<String> getKeys() {
    return _data.keys.toList();
  }
}
