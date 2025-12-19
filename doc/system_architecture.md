# PyTavern 系统架构设计文档 (System Architecture Design Document)

**版本**: 2.0
**状态**: Draft
**最后更新**: 2025-12-19
**参考文档**: `doc/合并.md`, `doc/plan.md`, `doc/升级版设计.md`

---

## 1. 架构概览 (Architecture Overview)

本系统采用 **混合 Agent 架构 (Hybrid Agent Architecture)**，核心设计理念是 **“数据与逻辑分离，确定性编排与概率性生成结合”**。

### 1.1 系统边界与分层

系统划分为三个物理隔离但逻辑紧密的层次：

1.  **表现层 (Presentation Layer)**: 负责用户交互与界面渲染。
    *   **Flutter UI**: 原生高性能聊天界面。
    *   **Webview**: 承载动态 HTML/JS 组件（如状态栏）。
2.  **编排层 (Orchestration Layer)**: 系统的“大脑”，负责流程控制与 Prompt 组装。
    *   **Orchestrator**: 核心调度器。
    *   **Prompt Engine**: 负责将数据组装为最终 Prompt。
3.  **数据与基础设施层 (Data & Infrastructure Layer)**: 负责数据的存储、检索与聚合。
    *   **Context Pipeline**: **核心组件**，统一的数据聚合服务。
    *   **History Engine**: 基于树状结构的历史管理。
    *   **World Engine**: 规则、Lore 与状态管理。

### 1.2 架构拓扑图

```mermaid
graph TD
    %% 样式定义
    classDef ui fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef orch fill:#fff3e0,stroke:#e65100,stroke-width:2px;
    classDef data fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px;
    classDef ext fill:#f3e5f5,stroke:#4a148c,stroke-width:2px;

    User((用户))

    subgraph Presentation [表现层]
        UI_Chat[聊天界面]:::ui
        UI_Webview[Webview 组件]:::ui
    end

    subgraph Orchestration [编排层]
        Orchestrator[Orchestrator (总线)]:::orch
        Prompt_Assembler[Prompt 组装器]:::orch
        SXML_Parser[SXML 解析器]:::orch
    end

    subgraph Agents [Agent 服务]
        Planner[Planner Agent]:::ext
        Generator[Core LLM]:::ext
    end

    subgraph Data_Infra [数据层 - Context Pipeline]
        Pipeline_Service[Context Pipeline Service]:::data
        
        subgraph Engines
            History_Engine[History Engine (Tree)]:::data
            World_Engine[World Engine (State/Lore)]:::data
            Vector_DB[Vector DB (RAG)]:::data
        end
    end

    %% 连接
    User <--> UI_Chat
    UI_Chat <--> Orchestrator
    UI_Webview <--> Orchestrator

    Orchestrator --> Planner
    Orchestrator --> Generator
    Orchestrator --> SXML_Parser
    Orchestrator --> Prompt_Assembler

    Prompt_Assembler -- "请求上下文快照" --> Pipeline_Service
    Pipeline_Service -- "聚合数据" --> Engines
    
    SXML_Parser -- "状态变更/新历史" --> History_Engine
    SXML_Parser -- "状态变更" --> World_Engine
```

---

## 2. SXML 协议定义 (SXML Protocol)

为了确保 LLM 输出的可解析性与鲁棒性，我们定义了 **SXML (Simplified XML)** 协议。该协议是 XML 的严格子集，专为流式解析和 LLM 生成优化。

### 2.1 核心语法规则

1.  **无自闭合标签**: 所有标签必须显式闭合。
    *   ✅ `<action>attack</action>`
    *   ❌ `<action value="attack" />`
2.  **无转义字符**: 内容区域视为纯文本（CDATA），解析器不处理 `<` 等转义实体。
    *   ✅ `<content>1 < 2</content>`
    *   ❌ `<content>1 < 2</content>`
3.  **浅层嵌套**: 推荐最大嵌套深度不超过 2 层，降低解析复杂度。
4.  **容错性**: 解析器支持自动闭合未闭合的标签（Auto-closing），以应对 LLM 输出中断的情况。

### 2.2 标准标签集

LLM 的输出必须遵循以下结构：

```xml
<root>
    <!-- 思维链 (可选) -->
    <thought>
        分析用户意图...
        决定执行攻击动作...
    </thought>

    <!-- 状态变更 (可选) -->
    <state_update>
        <set key="hp" value="90"></set>
        <add key="gold" value="10"></add>
    </state_update>

    <!-- 最终回复 (必须) -->
    <reply>
        你挥舞长剑，击中了哥布林！
    </reply>
</root>
```

### 2.3 解析逻辑 (基于 Dart 实现)

解析器 (`StreamXmlParser`) 采用正则驱动的状态机模式：
1.  **流式输入**: 逐字符/逐块接收 LLM 输出。
2.  **实时事件**: 触发 `onTagOpen`, `onTagClose`, `onText` 事件。
3.  **自动修复**: 流结束时，自动闭合栈中剩余的所有标签，确保数据完整性。

---

## 3. 上下文管道设计 (Context Pipeline Design)

**Context Pipeline** 是数据层的核心聚合器，它作为**历史与世界观的统率系统**，负责维护数据的完整性与一致性。它不负责“如何用数据”，只负责“提供高质量的数据”。

### 3.1 扩展性设计 (Extensibility Design)

Context Pipeline 采用 **插件化架构 (Plugin-based Architecture)**，不再硬编码固定的数据链。它由以下核心组件构成：

1.  **Context Source Registry (源注册表)**: 允许注册新的数据提供者（如 `HistorySource`, `WorldStateSource`, `RAGSource`）。
2.  **Context Store (上下文仓库)**: 一个通用的键值存储，用于存放非链式、非结构化的临时数据。
    *   **用途**: 存储当前的 `Generation Record`、临时草稿、调试信息、或者插件注入的临时变量。
    *   **特性**: 不同节点之间的内容往往无关，不成链状。

### 3.2 核心数据通道 (Core Data Channels)

虽然架构支持扩展，但系统默认内置以下核心通道：

1.  **History Chain (历史链)**:
    *   **源**: `History Engine`。
    *   **内容**: 标准对话记录 (User/AI)。
    *   **策略**: 滑动窗口 (Sliding Window)。

2.  **State Chain (状态链)**:
    *   **源**: `World Engine`。
    *   **内容**: RPG 数值 (HP, MP)、位置、时间。
    *   **策略**: 全量保留，高优先级。

3.  **RAG Chain (检索增强链)**:
    *   **源**: `Vector DB`。
    *   **内容**: 记忆片段。
    *   **策略**: 语义检索 + Token 预算裁剪。

4.  **Event Manager (事件管理器) [Future Implementation]**:
    *   **定位**: 不仅仅是数据链，而是一个复杂的**状态机**。
    *   **职责**: 管理事件的生命周期（触发 -> 进行中 -> 结束/结算）。
    *   **注释**: 留作未来开发

### 3.3 管道结构图

```mermaid
graph LR
    subgraph Data_Sources [数据源插件]
        H[History Source]
        W[State Source]
        R[RAG Source]
        E[Event Manager (Future)]
        O[Other Plugins...]
    end

    subgraph Context_Pipeline [Context Pipeline Service]
        direction TB
        Registry[源注册表]
        Store[Context Store (KV)]
        Aggregator[聚合与裁剪]
    end

    subgraph Output [输出]
        Context_Object[Context Snapshot]
    end

    H & W & R & E & O -.->|注册| Registry
    Registry -->|拉取数据| Aggregator
    Store -->|注入临时数据| Aggregator
    Aggregator --> Context_Object
```

---

## 4. 详细数据流 (Detailed Data Flow)

本节描述从用户输入到最终状态更新的完整数据流转。

### 4.1 阶段一：上下文组装 (Context Assembly)

1.  **用户输入**: 用户发送消息 "攻击哥布林"。
2.  **Orchestrator 请求**: 向 `Context Pipeline` 请求当前上下文快照。
3.  **Pipeline 响应**: 返回包含 History, State, Lore 的结构化对象 `ContextSnapshot`。
4.  **Prompt 组装**: `Prompt Assembler` 根据 `ContextSnapshot` 和预设模板，构建最终 Prompt 字符串。

### 4.2 阶段二：生成与解析 (Generation & Parsing)

1.  **LLM 生成**: `Core LLM` 接收 Prompt，开始流式输出 SXML。
2.  **流式解析**: `SXML Parser` 实时监听输出流。
    *   检测到 `<thought>`: 缓冲思维链内容。
    *   检测到 `<state_update>`: 解析键值对，准备更新。
    *   检测到 `<reply>`: 实时推送到 UI 显示。

### 4.3 阶段三：状态同步 (State Synchronization)

1.  **事务提交**: 生成结束后，Orchestrator 收集所有解析出的数据。
2.  **历史写入**: 调用 `History Engine`，创建新的 `Context Node` (包含 User Input) 和 `Generation Record` (包含 AI Reply)。
3.  **状态更新**:
    *   将 `<state_update>` 中的变更应用到 `World Engine`。
    *   生成新的状态快照，并关联到当前的 `Context Node` 上（实现时间旅行支持）。

---

## 5. 请求/响应序列图 (Sequence Diagram)

```mermaid
sequenceDiagram
    participant U as User
    participant O as Orchestrator
    participant P as Context Pipeline
    participant L as LLM
    participant S as SXML Parser
    participant H as History Engine

    U->>O: 发送消息
    
    Note over O, P: 1. 获取数据
    O->>P: getContextSnapshot(sessionId)
    P-->>O: ContextSnapshot (History, State, Lore)

    Note over O, L: 2. 生成
    O->>O: assemblePrompt(Snapshot)
    O->>L: streamGenerate(Prompt)

    Note over L, S: 3. 解析与展示
    loop Streaming
        L-->>S: SXML Chunk
        S-->>O: Parsed Event (Tag/Text)
        O-->>U: Update UI (Reply)
    end

    Note over O, H: 4. 持久化
    O->>H: addNode(UserMsg, StateSnapshot)
    O->>H: addRecord(AIReply, SXML_Data)