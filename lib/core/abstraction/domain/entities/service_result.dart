import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_result.freezed.dart';

/// 跨平台调用的统一返回结果
/// 使用 Freezed 联合类型来强制处理成功和失败两种情况
@freezed
class ServiceResult<T> with _$ServiceResult<T> {
  const factory ServiceResult.success(T data) = _Success<T>;
  const factory ServiceResult.failure({
    required String code,
    required String message,
    dynamic details,
  }) = _Failure<T>;
}