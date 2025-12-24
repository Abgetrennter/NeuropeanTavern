import 'core/pipeline.dart';
import 'services/mock_orchestrator.dart';
import 'shuttles/skein_builder/skein_builder_shuttle.dart';

/// Jacquard 工厂
///
/// 提供预配置的 Pipeline 和 Orchestrator 创建方法。
/// 简化了 Jacquard 组件的初始化过程。
///
/// TODO:
/// - 实现更多 Shuttle 的注册
/// - 支持自定义 Pipeline 配置
/// - 实现完整的 JacquardOrchestrator
class JacquardFactory {
  /// 创建标准流水线
  ///
  /// 标准流水线包含以下 Shuttle：
  /// 1. SkeinBuilder - 构建 Skein 容器
  /// 2. TODO: Assembler - 渲染 Prompt 字符串
  /// 3. TODO: Invoker - 调用 LLM API
  /// 4. TODO: Parser - 解析 LLM 输出
  /// 5. TODO: Updater - 更新状态
  static Pipeline createStandardPipeline() {
    final pipeline = BasicPipeline();

    print('🏭 [JacquardFactory] 创建标准流水线...');

    // 添加 SkeinBuilder Shuttle
    final skeinBuilder = SkeinBuilderShuttle();
    pipeline.addShuttle(skeinBuilder);
    print('  ➕ SkeinBuilder');

    // TODO: 添加更多 Shuttle
    // final assembler = AssemblerShuttle();
    // pipeline.addShuttle(assembler);
    // print('  ➕ Assembler');

    print('✅ 标准流水线创建完成，包含 ${pipeline.shuttles.length} 个 Shuttle');

    return pipeline;
  }

  /// 创建轻量级流水线
  ///
  /// 仅包含基本的 SkeinBuilder，用于快速测试
  static Pipeline createMinimalPipeline() {
    final pipeline = BasicPipeline();
    
    print('🏭 [JacquardFactory] 创建轻量级流水线...');
    
    final skeinBuilder = SkeinBuilderShuttle();
    pipeline.addShuttle(skeinBuilder);
    
    print('✅ 轻量级流水线创建完成');
    
    return pipeline;
  }

  /// 创建自定义流水线
  ///
  /// 允许用户指定要包含的 Shuttle
  static Pipeline createCustomPipeline(List<dynamic> shuttles) {
    final pipeline = BasicPipeline();
    
    print('🏭 [JacquardFactory] 创建自定义流水线...');
    
    for (final shuttle in shuttles) {
      pipeline.addShuttle(shuttle);
      print('  ➕ ${shuttle.toString()}');
    }
    
    print('✅ 自定义流水线创建完成，包含 ${pipeline.shuttles.length} 个 Shuttle');
    
    return pipeline;
  }

  /// 创建 Mock 编排器（带标准流水线）
  ///
  /// 这是最常用的方法，用于开发和测试
  static MockJacquardOrchestrator createMockOrchestrator({
    bool useStandardPipeline = true,
  }) {
    print('🏭 [JacquardFactory] 创建 Mock 编排器...');
    
    final pipeline = useStandardPipeline ? createStandardPipeline() : createMinimalPipeline();
    final orchestrator = MockJacquardOrchestrator(pipeline);
    
    print('✅ Mock 编排器创建完成');
    
    return orchestrator;
  }

  /// 打印 Pipeline 信息
  static void printPipelineInfo(Pipeline pipeline) {
    print('📊 Pipeline 信息:');
    print('  Shuttle 数量: ${pipeline.shuttles.length}');
    for (int i = 0; i < pipeline.shuttles.length; i++) {
      final shuttle = pipeline.shuttles[i];
      print('  ${i + 1}. ${shuttle.name}');
    }
  }
}
