import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neuropean/core/abstraction/data/repositories/method_channel_native_bridge.dart';
import 'package:neuropean/core/abstraction/domain/repositories/i_native_bridge.dart';

/// 原生桥接层的依赖注入提供者
/// 
/// 在 UI 层使用: ref.watch(nativeBridgeProvider)
/// 在测试时可以使用: overrides: [nativeBridgeProvider.overrideWithValue(MockNativeBridge())]
final nativeBridgeProvider = Provider<INativeBridge>((ref) {
  // 这里未来可以根据 Platform.isWindows ? WindowsFfiBridge() : MethodChannelNativeBridge() 
  // 来动态切换不同的实现策略
  // 目前统一使用 MethodChannel 实现
  final bridge = MethodChannelNativeBridge();
  
  // 注册销毁回调，确保资源释放
  ref.onDispose(() {
    bridge.dispose();
  });
  
  return bridge;
});