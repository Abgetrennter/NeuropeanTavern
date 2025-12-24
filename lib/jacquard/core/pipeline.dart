import 'shuttle_interface.dart';

/// 流水线接口
///
/// Pipeline 是 Jacquard 编排层的核心抽象，负责按顺序执行注册的 Shuttle。
/// 每个 Shuttle 代表一个处理阶段，数据在 Shuttle 之间传递。
///
/// 标准流水线包含以下阶段：
/// 1. Planner - 分析意图，决定工具调用
/// 2. Skein Builder - 构建结构化 Prompt 容器
/// 3. Assembler - 将 Skein 渲染为最终字符串
/// 4. Invoker - 调用 LLM API
/// 5. Parser - 解析 LLM 输出
/// 6. Updater - 提交状态变更
///
/// TODO: 实现完整的 Pipeline
abstract class Pipeline {
  /// 执行流水线
  ///
  /// [input] 输入数据，通常是 Map 或自定义对象
  /// Shuttle 按注册顺序依次处理数据
  Future<void> execute(dynamic input);

  /// 添加 Shuttle 到流水线
  ///
  /// [shuttle] 要添加的 Shuttle 实例
  void addShuttle(ShuttleInterface shuttle);

  /// 清空所有 Shuttle
  void clearShuttles();

  /// 获取所有 Shuttle
  List<ShuttleInterface> get shuttles;
}

/// 基础流水线实现
///
/// 简单的顺序执行实现，用于开发和测试
class BasicPipeline implements Pipeline {
  final List<ShuttleInterface> _shuttles = [];

  @override
  Future<void> execute(dynamic input) async {
    for (final shuttle in _shuttles) {
      await shuttle.process(input);
    }
  }

  @override
  void addShuttle(ShuttleInterface shuttle) {
    _shuttles.add(shuttle);
  }

  @override
  void clearShuttles() {
    _shuttles.clear();
  }

  @override
  List<ShuttleInterface> get shuttles => List.unmodifiable(_shuttles);
}
