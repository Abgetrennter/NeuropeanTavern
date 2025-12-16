import 'dart:typed_data';
import '../../data/models/character_card_model.dart';

abstract class CharacterRepository {
  /// Extracts character information from a PNG file.
  Future<CharacterCard> importFromPng(Uint8List fileBytes);
  
  /// Extracts character information from a JSON string.
  Future<CharacterCard> importFromJson(String jsonContent);
}