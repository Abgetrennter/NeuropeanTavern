import 'package:flutter/services.dart';
import 'package:neuropean/core/abstraction/domain/entities/service_result.dart';
import 'package:neuropean/core/abstraction/domain/repositories/i_native_bridge.dart';

/// 基于 MethodChannel 的通用原生桥接实现
/// 适用于 Android 和 Windows 的常规通信
class MethodChannelNativeBridge implements INativeBridge {
  // 定义主通信通道，建议使用反向域名风格
  static const _methodChannel = MethodChannel('com.neuropean.app/bridge');
  
  // 缓存 EventChannel，避免重复创建
  final Map<String, EventChannel> _eventChannels = {};

  @override
  Future<ServiceResult<T>> invokeMethod<T>(String method, [dynamic arguments]) async {
    try {
      final result = await _methodChannel.invokeMethod<T>(method, arguments);
      // 如果原生端返回 null 且 T 不为可空类型，这里可能会抛出异常，需注意业务逻辑
      // 这里假设原生端成功时总会返回符合 T 类型的数据
      return ServiceResult.success(result as T);
    } on PlatformException catch (e) {
      // 捕获原生端的明确错误
      return ServiceResult.failure(
        code: e.code,
        message: e.message ?? 'Unknown native error',
        details: e.details,
      );
    } catch (e) {
      // 捕获其他未预期的 Dart 端错误（如类型转换错误）
      return ServiceResult.failure(
        code: 'DART_ERROR',
        message: e.toString(),
      );
    }
  }

  @override
  Stream<T> receiveBroadcastStream<T>(String channelName, [dynamic arguments]) {
    // 懒加载 EventChannel
    final channel = _eventChannels.putIfAbsent(
      channelName, 
      () => EventChannel(channelName),
    );
    
    return channel.receiveBroadcastStream(arguments).map((event) {
      // 这里可以添加统一的数据转换逻辑
      return event as T;
    }).handleError((error) {
      // 流中的错误处理，通常 EventChannel 的错误也是 PlatformException
      if (error is PlatformException) {
        throw ServiceResult.failure(
          code: error.code,
          message: error.message ?? 'Stream error',
          details: error.details,
        );
      }
      throw error;
    });
  }

  @override
  void dispose() {
    _eventChannels.clear();
  }
}