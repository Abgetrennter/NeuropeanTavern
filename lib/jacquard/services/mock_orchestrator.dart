import 'dart:async';
import '../core/pipeline.dart';
import '../models/chat_message.dart';

/// Mock 编排器
///
/// 这是基于新架构的 Mock 实现，用于开发和测试。
/// 它使用 Pipeline 模式，但目前只包含简单的模拟逻辑。
///
/// TODO: 实现完整的 JacquardOrchestrator
class MockJacquardOrchestrator {
  final Pipeline _pipeline;
  final List<ChatMessage> _history = [];
  int _turnCounter = 0;

  MockJacquardOrchestrator([Pipeline? pipeline])
      : _pipeline = pipeline ?? BasicPipeline();

  /// 处理用户消息
  ///
  /// 返回流式响应
  Stream<String> processUserMessage(String input) async* {
    print('🧵 [MockJacquardOrchestrator] 处理用户消息: $input');

    // 添加用户消息到历史
    final userMessage = ChatMessage.user(
      content: input,
      turn: _turnCounter,
    );
    _history.add(userMessage);
    print('📝 添加用户消息: ${userMessage.id}');

    // 执行流水线（目前是空的）
    final requestData = <String, dynamic>{
      'userInput': input,
      'turn': _turnCounter,
      'userMessage': userMessage,
    };

    try {
      await _pipeline.execute(requestData);
      print('✅ Pipeline 执行完成');
    } catch (e) {
      print('⚠️  Pipeline 执行错误: $e');
    }

    // 检查是否有 Skein 生成
    if (requestData.containsKey('skein')) {
      final skein = requestData['skein'];
      print('🧶 生成 Skein: $skein');
    }

    // 模拟处理延迟
    await Future.delayed(const Duration(milliseconds: 500));

    // 生成模拟响应
    final response = _generateMockResponse(input);
    final assistantMessage = ChatMessage.assistant(
      content: response,
      turn: _turnCounter,
    );
    _history.add(assistantMessage);
    print('📝 添加助手消息: ${assistantMessage.id}');

    // 增加回合计数
    _turnCounter++;

    // 流式返回响应
    final words = response.split(' ');
    for (int i = 0; i < words.length; i++) {
      yield words[i] + (i < words.length - 1 ? ' ' : '');
      await Future.delayed(const Duration(milliseconds: 100));
    }

    print('✅ 消息处理完成');
  }

  /// 生成模拟响应
  String _generateMockResponse(String input) {
    final responses = [
      '这是对"$input"的模拟回复。在实际实现中，这里会调用 LLM API。',
      '我理解了你的输入：$input。这只是一个 Mock 响应。',
      '感谢你的消息：$input。目前使用的是 Mock 编排器。',
      '这是一个模拟回复。实际的 Jacquard 编排器会通过 Pipeline 处理请求。',
    ];
    
    return responses[_history.length % responses.length];
  }

  /// 获取聊天历史
  List<ChatMessage> get history => List.unmodifiable(_history);

  /// 获取当前回合数
  int get currentTurn => _turnCounter;

  /// 清除聊天历史
  Future<void> clearHistory() async {
    _history.clear();
    _turnCounter = 0;
    print('🗑️  聊天历史已清除');
  }

  /// 获取 Pipeline
  Pipeline get pipeline => _pipeline;

  /// 添加 Shuttle 到 Pipeline
  void addShuttle(dynamic shuttle) {
    _pipeline.addShuttle(shuttle);
    print('➕ 添加 Shuttle: ${shuttle.toString()}');
  }
}
