/// 基础设施层占位符
///
/// 基础设施层提供跨平台抽象，包括：
/// - LLM 提供商接口
/// - 存储抽象
/// - 向量数据库抽象
/// - 原生桥接接口
///
/// TODO: 实现基础设施层
/// 文档参考: doc/architecture/05_infrastructure_layer.md

class InfrastructurePlaceholder {
  /// 占位符初始化方法
  /// TODO: 实现完整的基础设施层
  static void init() {
    throw UnimplementedError(
      '基础设施层尚未实现\n'
      '需要实现：\n'
      '1. LLM Provider 接口与实现\n'
      '2. Storage 存储抽象\n'
      '3. Vector Store 向量数据库\n'
      '4. Native Bridge 原生桥接\n'
    );
  }

  /// 占位符方法
  static void placeholderMethod() {
    throw UnimplementedError('InfrastructurePlaceholder: 功能尚未实现');
  }
}
