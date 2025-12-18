import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:neuropean/core/abstraction/abstraction.dart';

// 生成 Mock 类
@GenerateMocks([INativeBridge])
import 'native_bridge_test.mocks.dart';

void main() {
  late MockINativeBridge mockBridge;

  setUp(() {
    mockBridge = MockINativeBridge();
  });

  group('NativeBridge Interface Tests', () {
    test('invokeMethod returns success result', () async {
      // Arrange
      const testMethod = 'testMethod';
      const testResult = 'testData';
      
      when(mockBridge.invokeMethod<String>(testMethod))
          .thenAnswer((_) async => const ServiceResult.success(testResult));

      // Act
      final result = await mockBridge.invokeMethod<String>(testMethod);

      // Assert
      result.when(
        success: (data) => expect(data, testResult),
        failure: (_, __, ___) => fail('Should be success'),
      );
      
      verify(mockBridge.invokeMethod<String>(testMethod)).called(1);
    });

    test('invokeMethod returns failure result', () async {
      // Arrange
      const testMethod = 'failMethod';
      const errorCode = 'ERROR';
      
      when(mockBridge.invokeMethod<String>(testMethod))
          .thenAnswer((_) async => const ServiceResult.failure(
                code: errorCode,
                message: 'Something went wrong',
              ));

      // Act
      final result = await mockBridge.invokeMethod<String>(testMethod);

      // Assert
      result.when(
        success: (_) => fail('Should be failure'),
        failure: (code, message, _) {
          expect(code, errorCode);
          expect(message, 'Something went wrong');
        },
      );
    });
  });
}