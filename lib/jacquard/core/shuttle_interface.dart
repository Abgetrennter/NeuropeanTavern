/// Shuttle 接口（逻辑单元）
///
/// Shuttle 是 Jacquard 流水线中的基本处理单元。
/// 每个 Shuttle 负责一个特定的处理阶段，数据在 Shuttle 之间传递。
///
/// Shuttle 的职责：
/// - 接收输入数据（通常是 Map 或自定义对象）
/// - 执行特定的处理逻辑
/// - 修改或扩展输入数据
/// - 将结果传递给下一个 Shuttle
///
/// 标准 Shuttle 类型：
/// - PlannerShuttle - 意图分析与工具调用决策
/// - SkeinBuilderShuttle - 构建 Skein 容器
/// - AssemblerShuttle - 渲染 Prompt 字符串
/// - InvokerShuttle - 调用 LLM API
/// - ParserShuttle - 解析 LLM 输出
/// - UpdaterShuttle - 更新状态
///
/// TODO: 实现各种具体的 Shuttle
abstract class ShuttleInterface {
  /// 处理数据
  ///
  /// [input] 输入数据，通常是 Map 或自定义对象
  /// Shuttle 可以直接修改 input 对象，也可以添加新字段
  Future<void> process(dynamic input);

  /// Shuttle 名称
  ///
  /// 用于调试和日志记录
  String get name;

  /// 执行顺序优先级
  ///
  /// 数字越小越先执行，默认为 0
  int get priority => 0;
}

/// 基础 Shuttle 实现
///
/// 提供默认实现的抽象类，方便创建新的 Shuttle
abstract class BaseShuttle implements ShuttleInterface {
  @override
  String get name => runtimeType.toString();

  @override
  int get priority => 0;

  /// 处理前的钩子方法（可选重写）
  Future<void> beforeProcess(dynamic input) async {}

  /// 处理后的钩子方法（可选重写）
  Future<void> afterProcess(dynamic input) async {}

  /// 实际处理逻辑（子类必须实现）
  @override
  Future<void> process(dynamic input) async {
    await beforeProcess(input);
    await doProcess(input);
    await afterProcess(input);
  }

  /// 子类实现的核心处理逻辑
  Future<void> doProcess(dynamic input);
}
