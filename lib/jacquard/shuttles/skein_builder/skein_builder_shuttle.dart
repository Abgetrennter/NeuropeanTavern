import '../../core/shuttle_interface.dart';
import '../../models/skein.dart';

/// Skein Builder Shuttle
///
/// 这是 Jacquard 流水线中的第一个 Shuttle，负责构建 Skein 容器。
/// 它从输入数据中提取信息，创建结构化的 Prompt 容器。
///
/// TODO:
/// - 从 Mnemosyne 获取状态快照
/// - 加载 Character State Schema
/// - 集成 Prompt 模板系统
class SkeinBuilderShuttle extends BaseShuttle {
  @override
  String get name => 'SkeinBuilder';

  @override
  Future<void> doProcess(dynamic input) async {
    print('🧶 [SkeinBuilder] 开始构建 Skein...');

    if (input is! Map) {
      print('⚠️  输入不是 Map 类型，跳过 Skein 构建');
      return;
    }

    final map = input as Map<String, dynamic>;

    // 提取基础数据
    final userInput = map['userInput'] as String? ?? '';
    final systemPrompt = map['systemPrompt'] as String? ?? 'You are a helpful assistant.';
    final lore = map['lore'] as String? ?? '';

    // TODO: 从 Mnemosyne 获取状态快照
    final state = map['state'] as Map<String, dynamic>? ?? {};

    // 提取示例对话（如果有）
    final examples = <DialogueEntry>[];
    if (map.containsKey('examples') && map['examples'] is List) {
      final examplesList = map['examples'] as List;
      for (final example in examplesList) {
        if (example is Map) {
          examples.add(DialogueEntry(
            role: example['role'] as String? ?? 'user',
            content: example['content'] as String? ?? '',
          ));
        }
      }
    }

    // 创建 Skein
    final skein = Skein(
      systemPrompt: systemPrompt,
      lore: lore,
      userInput: userInput,
      state: state,
      examples: examples,
    );

    // 将 Skein 添加到输入数据中，传递给下一个 Shuttle
    input['skein'] = skein;

    print('✅ [SkeinBuilder] Skein 构建完成');
    print('📊 Skein 信息:');
    print('  - System Prompt: ${skein.systemPrompt.length} 字符');
    print('  - Lore: ${skein.lore.length} 字符');
    print('  - User Input: ${skein.userInput.length} 字符');
    print('  - State: ${skein.state.length} 项');
    print('  - Examples: ${skein.examples.length} 条');
    print('  - 渲染长度: ${skein.render().length} 字符');
  }
}
