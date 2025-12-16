import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/character_repository_impl.dart';

class TestPanelPage extends StatefulWidget {
  const TestPanelPage({super.key});

  @override
  State<TestPanelPage> createState() => _TestPanelPageState();
}

class _TestPanelPageState extends State<TestPanelPage> {
  String _log = 'Ready to import...';
  final _repository = CharacterRepositoryImpl();

  Future<void> _importCharacter() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'json'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final bytes = file.bytes;
        final extension = file.extension?.toLowerCase();

        if (bytes == null) {
          setState(() {
            _log = 'Error: Could not read file data.';
          });
          return;
        }

        setState(() {
          _log = 'Processing ${file.name}...';
        });

        final character = extension == 'png'
            ? await _repository.importFromPng(bytes)
            : await _repository.importFromJson(utf8.decode(bytes));

        setState(() {
          const encoder = JsonEncoder.withIndent('  ');
          _log = 'Successfully imported:\n${encoder.convert(character.toJson())}';
        });
      }
    } catch (e) {
      setState(() {
        _log = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/chat'),
                  icon: const Icon(Icons.chat),
                  label: const Text('Open Chat Interface'),
                ),
                ElevatedButton.icon(
                  onPressed: _importCharacter,
                  icon: const Icon(Icons.file_upload),
                  label: const Text('Import Character Card'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Log / Output:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[100],
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _log,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}