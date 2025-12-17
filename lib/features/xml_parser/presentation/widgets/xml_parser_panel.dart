import 'dart:async';

import 'package:flutter/material.dart';
import '../../domain/entity/xml_node.dart';
import '../../domain/utils/static_xml_parser.dart';

class XmlParserPanel extends StatefulWidget {
  const XmlParserPanel({super.key});

  @override
  State<XmlParserPanel> createState() => _XmlParserPanelState();
}

class _XmlParserPanelState extends State<XmlParserPanel> {
  final TextEditingController _controller = TextEditingController();
  List<XmlNode> _parsedNodes = [];
  Timer? _debounce;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _parse(text);
    });
  }

  void _parse(String text) {
    try {
      final nodes = StaticXmlParser.parse(text);
      setState(() {
        _parsedNodes = nodes;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _parsedNodes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XML Parser Playground'),
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
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input XML',
                  alignLabelWithHint: true,
                ),
                onChanged: _onTextChanged,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[50],
              child: _error != null
                  ? Center(
                      child: Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : _parsedNodes.isEmpty
                      ? const Center(child: Text('No parsed data'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: _parsedNodes.length,
                          itemBuilder: (context, index) {
                            return _buildNodeView(_parsedNodes[index]);
                          },
                        ),
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
        padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
        child: Text(
          '"${node.text.trim()}"',
          style: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
        ),
      );
    } else if (node is XmlElement) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: ExpansionTile(
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
            ],
          ),
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.only(left: 16.0),
          children: node.children.map(_buildNodeView).toList(),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}