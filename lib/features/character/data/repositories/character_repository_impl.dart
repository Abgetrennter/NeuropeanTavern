import 'dart:convert';
import 'dart:typed_data';

import '../../domain/repositories/character_repository.dart';
import '../models/character_card_model.dart';
import '../utils/character_card_parser.dart';
import '../utils/tavern_card_validator.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  @override
  Future<CharacterCard> importFromPng(Uint8List fileBytes) async {
    try {
      final jsonString = CharacterCardParser.read(fileBytes);
      return _processCharacterData(jsonString);
    } catch (e) {
      throw Exception('Failed to import character from PNG: $e');
    }
  }

  @override
  Future<CharacterCard> importFromJson(String jsonContent) async {
    try {
      return _processCharacterData(jsonContent);
    } catch (e) {
      throw Exception('Failed to import character from JSON: $e');
    }
  }

  CharacterCard _processCharacterData(String jsonString) {
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final validator = TavernCardValidator(jsonData);
    final validationResult = validator.validate();

    if (validationResult == 0) {
      throw Exception(
          'Invalid character card data: ${validator.lastValidationError}');
    }

    if (validationResult == 1) {
      // Convert V1 to V2/V3
      return _convertToV3(jsonData);
    } else {
      // For V2 and V3, parse directly to the model
      // Since our model is a superset (V3), it handles V2 data as well.
      return CharacterCard.fromJson(jsonData);
    }
  }

  CharacterCard _convertToV3(Map<String, dynamic> v1Data) {
    // Map V1 fields to V3 structure
    final v3Data = CharacterCardModel(
      name: v1Data['name'] ?? '',
      description: v1Data['description'] ?? '',
      personality: v1Data['personality'] ?? '',
      scenario: v1Data['scenario'] ?? '',
      firstMes: v1Data['first_mes'] ?? '',
      mesExample: v1Data['mes_example'] ?? '',
      creatorNotes: v1Data['creator_notes'],
      systemPrompt: v1Data['system_prompt'],
      postHistoryInstructions: v1Data['post_history_instructions'],
      alternateGreetings: (v1Data['alternate_greetings'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      tags: (v1Data['tags'] as List?)?.map((e) => e.toString()).toList(),
      creator: v1Data['creator'],
      characterVersion: v1Data['character_version'],
      extensions: v1Data['extensions'],
      characterBook: v1Data['character_book'],
      // V3 fields are null for V1
    );

    return CharacterCard(
      spec: 'chara_card_v3',
      specVersion: '3.0',
      data: v3Data,
    );
  }
}