# Clotho (Neuropean)

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)![License](https://img.shields.io/badge/license-MIT-blue.svg)

**Clotho** 是一个旨在重新定义 AI 角色扮演（RPG）体验的次世代客户端。

我们不仅仅是在构建一个聊天界面，而是在探索 **"Hybrid Agency"（混合代理）** 的终极形态。针对现有方案（如 SillyTavern）在逻辑处理、上下文管理及性能上的痛点，Clotho 彻底摒弃了 Web 技术栈，采用 **Flutter/Dart** 原生架构，构建了一个**高性能、确定性与沉浸感并存**的交互容器。

---

## 📖 目录

- [🏛 设计哲学](#-设计哲学-the-caesar-principle)
- [🧩 核心架构](#-核心架构-the-trinity)
- [🏗 基础设施与迁移](#-基础设施与迁移)
- [🛠 技术栈](#-技术栈)
- [📚 文档索引](#-文档索引)
- [🚀 快速开始](#-快速开始)
- [🤝 贡献指南](#-贡献指南)

---

## 🏛 设计哲学 (The Caesar Principle)

Clotho 的架构基石遵循 **"凯撒原则" (The Caesar Principle)**：

> **"Render unto Caesar the things that are Caesar's, and unto God the things that are God's."**
> **(凯撒的归凯撒，上帝的归上帝)**

*   **🏛 凯撒的归凯撒 (Code's Domain)**: 逻辑判断、数值计算、状态管理、流程控制。这些必须由 **Jacquard** 与 **Mnemosyne** 严密掌控，绝不外包给 LLM。
*   **✨ 上帝的归上帝 (LLM's Domain)**: 语义理解、情感演绎、剧情生成、文本润色。这是 LLM 的神性所在。

---

## 🧩 核心架构 (The Trinity)

系统被抽象为三个物理隔离但逻辑紧密的生态：

### 1. 🧶 编排层: Jacquard (The Loom)
> *"系统的‘大脑’，负责确定性的流程编排。"*

*   **Pipeline Architecture**: 基于插件化的流水线设计，协调 Planner, Invoker, Parser 等组件。
*   **Skein (绞纱)**: 取代简单的字符串拼接，使用结构化的**异构容器**管理 System Prompt, Lore, User Input，支持动态裁剪与重组。
*   **Filament Protocol v2**: 专为 AI 交互设计的通信协议。
    *   **JSON State Updates**: 状态变更采用 `[OpCode, Path, Value]` 三元组，提高 Token 效率与解析鲁棒性。
    *   **Strict XML**: 确保 `<thought>`, `<reply>`, `<state_update>` 的精确解析。

### 2. 🧠 记忆层: Mnemosyne (The Memory)
> *"系统的‘海马体’，动态快照生成引擎。"*

*   **Dynamic Snapshotting (Punchcards)**: 不只是存储数据，而是基于**时间指针 (Time Pointer)** 瞬间投影出任意时刻的完整世界状态。支持无损的 **Undo (回溯)**、**Branching (分支)** 与 **Reroll (重绘)**。
*   **Multi-dimensional Chains**: 并行维护 History Chain (线性剧情), State Chain (关键帧+增量), RAG Chain (向量检索)。
*   **VWD (Value with Description)**: 引入 MVU 概念，状态值自带语义描述（如 `"health": [80, "0 is dead"]`），让 LLM 真正理解数值含义。

### 3. 🎭 表现层: Presentation (The Stage)
> *"纯粹的渲染与交互界面，Hybrid SDUI 架构。"*

*   **Stage & Control**: 布局哲学区分沉浸式“舞台”与功能性“控制台”，适配 Desktop, Tablet, Mobile 全平台。
*   **Hybrid SDUI**: 
    *   **Native Track**: 使用 **RFW (Remote Flutter Widgets)** 渲染高性能原生组件。
    *   **Web Track**: 使用 WebView 兼容复杂的第三方动态内容（如 HTML5 状态栏）。
*   **Input Draft**: UI 严禁直接修改业务数据，所有交互仅生成“输入草稿”或标准 Intent。

---

## 🏗 基础设施与迁移

### 🌉 跨平台基础设施
遵循 **Clean Architecture** 与 **依赖倒置原则 (DIP)**，通过 Repository 模式将 UI 与底层 OS 解耦。
*   **Android**: 基于 Kotlin Coroutines 的 MethodChannel 通信。
*   **Windows**: 采用 **Dart FFI (C++ DLL)** 处理高频/大数据（如本地 LLM 推理），利用共享内存实现极致性能。

### 📦 遗留生态迁移
针对 SillyTavern 庞大的生态资产（特别是 EJS 脚本），我们提供 **"交互式迁移向导" (Scan-Suggest-Interact)**。
*   拒绝全自动黑盒转译，而是引导用户将老旧逻辑映射为 Clotho 的现代组件（Mnemosyne Schema, UI Extensions, Jacquard Triggers）。

---

## 🛠 技术栈

本项目采用现代化的 Flutter 开发栈 (Dart SDK >= 3.10.4)：

- **Framework**: [Flutter](https://flutter.dev/) (Native Performance)
- **State Management**: [Riverpod](https://riverpod.dev/) (w/ `riverpod_generator`)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Persistence**: [Drift](https://drift.simonbinder.eu/) (SQLite)
- **Serialization**: [Freezed](https://pub.dev/packages/freezed) & [JsonSerializable](https://pub.dev/packages/json_serializable)
- **Networking**: [Dio](https://pub.dev/packages/dio)

---

## 📚 文档索引

详细的架构设计文档请参阅 `doc/architecture/`：

| 章节 | 标题 | 核心内容 |
| :--- | :--- | :--- |
| **00** | [全景索引 (Panorama)](doc/architecture/00_architecture_panorama.md) | 架构地图与导航 |
| **01** | [愿景与哲学 (Vision)](doc/architecture/01_vision_and_philosophy.md) | 凯撒原则, Hybrid Agency |
| **02** | [编排层 (Jacquard)](doc/architecture/02_jacquard_orchestration.md) | Pipeline, Skein, Filament v2 |
| **03** | [记忆层 (Mnemosyne)](doc/architecture/03_mnemosyne_data_engine.md) | Punchcards, VWD, Chains |
| **04** | [表现层 (Presentation)](doc/architecture/04_presentation_layer.md) | Hybrid SDUI, Stage & Control |
| **05** | [基础设施 (Infrastructure)](doc/architecture/05_infrastructure_layer.md) | DIP, Cross-Platform Strategy |
| **06** | [迁移策略 (Migration)](doc/architecture/06_migration_strategy.md) | Legacy Migration Wizard |

---

## 🚀 快速开始

### 环境准备

- **Flutter SDK**: `3.10.4` 或更高
- **IDE**: VS Code (推荐) 或 Android Studio

### 安装步骤

1.  **克隆仓库**

    ```bash
    git clone https://github.com/your-username/neuropean.git
    cd neuropean
    ```

2.  **安装依赖**

    ```bash
    flutter pub get
    ```

3.  **代码生成 (Build Runner)**
    本项目使用了 Freezed, Riverpod Generator 和 Drift，运行前**必须**执行代码生成。

    ```bash
    # 一次性生成
    dart run build_runner build -d

    # 或者在开发时持续监听变更
    dart run build_runner watch -d
    ```

4.  **运行项目**

    ```bash
    flutter run
    ```

---

## 🤝 贡献指南

我们非常欢迎社区贡献！如果您有兴趣改进 Clotho，请遵循以下步骤：

1.  Fork 本仓库。
2.  创建一个新的分支 (`git checkout -b feature/AmazingFeature`)。
3.  提交您的更改 (`git commit -m 'Add some AmazingFeature'`)。
4.  推送到分支 (`git push origin feature/AmazingFeature`)。
5.  开启一个 Pull Request。

请确保在提交前运行 `flutter test` 以验证代码的正确性。

---

## 📄 许可证

本项目基于 MIT 许可证开源。详情请参阅 [LICENSE](LICENSE) 文件。
