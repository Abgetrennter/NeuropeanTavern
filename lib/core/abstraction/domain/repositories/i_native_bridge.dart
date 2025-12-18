import 'package:neuropean/core/abstraction/domain/entities/service_result.dart';

/// 跨平台通信的底层抽象接口
/// 所有具体的业务服务（如 LLMService, FileService）都应依赖此接口或其派生接口
/// 而不应直接依赖 MethodChannel
abstract class INativeBridge {
  /// 发送指令并等待结果 (Command)
  /// [method]: 原生端对应的方法名
  /// [arguments]: 传递的参数 DTO (需序列化为 Map 或基础类型)
  Future<ServiceResult<T>> invokeMethod<T>(String method, [dynamic arguments]);

  /// 监听来自原生端的事件流 (Event)
  /// [channelName]: 事件通道名称
  Stream<T> receiveBroadcastStream<T>(String channelName, [dynamic arguments]);
  
  /// 释放资源
  void dispose();
}