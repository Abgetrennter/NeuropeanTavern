import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../domain/entity/xml_node.dart';
import '../../domain/entity/xml_stream_event.dart';
import '../../domain/utils/stream_xml_parser.dart';

class StreamXmlParserPanel extends StatefulWidget {
  const StreamXmlParserPanel({super.key});

  @override
  State<StreamXmlParserPanel> createState() => _StreamXmlParserPanelState();
}

class _StreamXmlParserPanelState extends State<StreamXmlParserPanel> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // 解析状态
  StreamXmlParser? _parser;
  StreamSubscription? _subscription;
  List<XmlNode> _roots = [];
  // 辅助栈，用于构建树：存储 [Node, ParentNode]
  // 但因为 XmlElement 的 children 是 List，我们只需要存 Element 即可
  final List<XmlElement> _elementStack = [];
  // 记录当前活跃（未闭合）的节点
  final Set<XmlElement> _activeNodes = {};
  
  // 模拟流的状态
  Timer? _simulationTimer;
  int _simulationCursor = 0;
  bool _isSimulating = false;
  String _log = '';

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _stopSimulation();
    super.dispose();
  }

  void _stopSimulation() {
    _simulationTimer?.cancel();
    _subscription?.cancel();
    _parser?.close();
    _parser = null;
    setState(() {
      _isSimulating = false;
    });
  }

  void _startSimulation() {
    if (_inputController.text.isEmpty) return;

    _stopSimulation();
    
    setState(() {
      _isSimulating = true;
      _roots = [];
      _elementStack.clear();
      _activeNodes.clear();
      _simulationCursor = 0;
      _log = 'Simulation started...\n';
    });

    _parser = StreamXmlParser();
    _subscription = _parser!.stream.listen(_onStreamEvent, onDone: () {
      setState(() => _log += 'Stream closed.\n');
    });

    // 模拟匀速流式输入
    const chunkSize = 5; // 每次发送的字符数
    const interval = Duration(milliseconds: 50);

    _simulationTimer = Timer.periodic(interval, (timer) {
      final text = _inputController.text;
      if (_simulationCursor >= text.length) {
        _parser!.close();
        timer.cancel();
        setState(() {
          _isSimulating = false;
          _log += 'Input exhausted.\n';
        });
        return;
      }

      final end = min(_simulationCursor + chunkSize, text.length);
      final chunk = text.substring(_simulationCursor, end);
      _simulationCursor = end;

      _parser!.feed(chunk);
      // 滚动到底部
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _onStreamEvent(XmlStreamEvent event) {
    setState(() {
      _log += '$event\n';
      
      if (event is XmlTagOpenEvent) {
        final newElement = XmlElement(
          tagName: event.tagName,
          attributes: event.attributes,
          children: [],
        );

        if (_elementStack.isEmpty) {
          _roots.add(newElement);
        } else {
          _elementStack.last.children.add(newElement);
        }
        _elementStack.add(newElement);
        _activeNodes.add(newElement);

      } else if (event is XmlTagCloseEvent) {
        // 找到最近的匹配标签并弹出
        // 注意：StreamParser 已经处理了容错，发出的 Close 事件通常是匹配的
        // 但为了保险，我们还是检查一下栈顶
        if (_elementStack.isNotEmpty) {
           // 简单的处理：只要栈里有这个标签，就一直弹到它为止
           // 实际上 StreamParser 的逻辑保证了 Close 事件是合法的
           // 这里我们简单地弹出栈顶，假设 Parser 已经做好了配对
           // 如果要更严谨，应该在栈里反向查找
           
           int matchIndex = -1;
           for (int i = _elementStack.length - 1; i >= 0; i--) {
             if (_elementStack[i].tagName == event.tagName) {
               matchIndex = i;
               break;
             }
           }
           
           if (matchIndex != -1) {
             while (_elementStack.length > matchIndex) {
               final popped = _elementStack.removeLast();
               _activeNodes.remove(popped);
             }
           }
        }

      } else if (event is XmlContentEvent) {
        if (_elementStack.isNotEmpty) {
          final parent = _elementStack.last;
          // 优化：如果最后一个子节点是文本，直接追加
          if (parent.children.isNotEmpty && parent.children.last is XmlText) {
            final lastText = parent.children.last as XmlText;
            // XmlText 是不可变的，所以我们需要替换它
            // 这里为了演示方便，我们假设 XmlText 的 text 是 final 的
            // 所以我们移除旧的，添加新的
            parent.children.removeLast();
            parent.children.add(XmlText(lastText.text + event.text));
          } else {
            parent.children.add(XmlText(event.text));
          }
        } else {
          // 根级别的文本（通常是空白或噪声，或者纯文本）
           if (_roots.isNotEmpty && _roots.last is XmlText) {
             final lastText = _roots.last as XmlText;
             _roots.removeLast();
             _roots.add(XmlText(lastText.text + event.text));
           } else {
             _roots.add(XmlText(event.text));
           }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream XML Parser'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 输入区
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Input XML:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: _isSimulating ? _stopSimulation : _startSimulation,
                        icon: Icon(_isSimulating ? Icons.stop : Icons.play_arrow),
                        label: Text(_isSimulating ? 'Stop' : 'Simulate Stream'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSimulating ? Colors.red[100] : Colors.green[100],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '<root><msg>Hello...</msg></root>',
                      ),
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // 展示区
          Expanded(
            flex: 2,
            child: Row(
              children: [
                // 左侧：事件日志
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black87,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Event Log:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Text(
                              _log,
                              style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 右侧：实时树视图
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Live DOM Tree:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: _roots.isEmpty
                              ? const Center(child: Text('Waiting for stream...'))
                              : ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: _roots.length,
                                  itemBuilder: (context, index) {
                                    return _buildNodeView(_roots[index]);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNodeView(XmlNode node) {
    if (node is XmlText) {
      if (node.text.trim().isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 2.0, bottom: 2.0),
        child: Text(
          '"${node.text}"', // 显示原始文本，包括换行
          style: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
        ),
      );
    } else if (node is XmlElement) {
      final isActive = _activeNodes.contains(node);
      // 使用 Key 强制重建组件以更新展开状态
      // 当节点从活跃变为非活跃时，Key 改变，组件重建，initiallyExpanded 变为 false (默认值)
      // 注意：这里我们希望活跃时展开，非活跃时收起。
      // 但 ExpansionTile 没有直接的 expanded 属性，只能通过 initiallyExpanded + Key 来控制。
      
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        elevation: 0,
        color: isActive ? Colors.blue[50] : Colors.white, // 活跃节点稍微高亮一下
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isActive ? Colors.blue : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: ExpansionTile(
          // 关键：Key 包含 isActive 状态
          key: ValueKey('${node.hashCode}_$isActive'),
          title: Row(
            children: [
              Text(
                '<${node.tagName}>',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontFamily: 'monospace',
                ),
              ),
              if (node.attributes.isNotEmpty) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    node.attributes.entries
                        .map((e) => '${e.key}="${e.value}"')
                        .join(' '),
                    style: TextStyle(
                      color: Colors.purple[300],
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (isActive)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            ],
          ),
          // 活跃时展开，非活跃时收起（因为 Key 变了，会重新初始化，此时 initiallyExpanded 为 false）
          // 等等，如果 initiallyExpanded 为 false，那它一开始就是收起的。
          // 我们希望：
          // 1. 刚创建时（活跃）：展开
          // 2. 变为非活跃时：收起
          // 所以：isActive 为 true 时 initiallyExpanded = true
          // isActive 为 false 时 initiallyExpanded = false
          initiallyExpanded: isActive,
          dense: true,
          childrenPadding: const EdgeInsets.only(left: 16.0),
          children: node.children.map(_buildNodeView).toList(),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}