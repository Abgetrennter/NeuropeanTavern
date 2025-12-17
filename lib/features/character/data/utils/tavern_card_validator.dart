//import '../models/character_card_model.dart';

class TavernCardValidator {
  final Map<String, dynamic> card;
  String? _lastValidationError;

  TavernCardValidator(this.card);

  String? get lastValidationError => _lastValidationError;

  /// Validate against V1 or V2 spec.
  /// Returns:
  /// - 1 for V1
  /// - 2 for V2
  /// - 3 for V3
  /// - 0 if invalid
  int validate() {
    _lastValidationError = null;

    // Check V3/V2 first as they are more specific (require 'spec' field)
    // V1 is a fallback for legacy cards that might share fields with V2/V3 top-level metadata
    if (validateV3()) {
      return 3;
    }

    if (validateV2()) {
      return 2;
    }

    if (validateV1()) {
      return 1;
    }

    return 0;
  }

  bool validateV1() {
    const requiredFields = [
      'name',
      'description',
      'personality',
      'scenario',
      'first_mes',
      'mes_example'
    ];
    for (final field in requiredFields) {
      if (!card.containsKey(field)) {
        _lastValidationError = field;
        return false;
      }
    }
    return true;
  }

  bool validateV2() {
    return _validateSpecV2() &&
        _validateSpecVersionV2() &&
        _validateDataV2() &&
        _validateCharacterBookV2();
  }

  bool validateV3() {
    return _validateSpecV3() && _validateSpecVersionV3() && _validateDataV3();
  }

  bool _validateSpecV2() {
    if (card['spec'] != 'chara_card_v2') {
      _lastValidationError = 'spec';
      return false;
    }
    return true;
  }

  bool _validateSpecVersionV2() {
    if (card['spec_version'] != '2.0') {
      _lastValidationError = 'spec_version';
      return false;
    }
    return true;
  }

  bool _validateDataV2() {
    final data = card['data'];

    if (data == null || data is! Map) {
      _lastValidationError = 'No tavern card data found';
      return false;
    }

    const requiredFields = [
      'name',
      'description',
      'personality',
      'scenario',
      'first_mes',
      'mes_example',
      'creator_notes',
      'system_prompt',
      'post_history_instructions',
      'alternate_greetings',
      'tags',
      'creator',
      'character_version',
      'extensions'
    ];

    for (final field in requiredFields) {
      if (!data.containsKey(field)) {
        _lastValidationError = 'data.$field';
        return false;
      }
    }

    return data['alternate_greetings'] is List &&
        data['tags'] is List &&
        data['extensions'] is Map;
  }

  bool _validateCharacterBookV2() {
    final data = card['data'] as Map<String, dynamic>;
    final characterBook = data['character_book'];

    if (characterBook == null) {
      return true;
    }
    
    if (characterBook is! Map) {
       _lastValidationError = 'data.character_book is not a Map';
       return false;
    }

    const requiredFields = ['extensions', 'entries'];
    for (final field in requiredFields) {
      if (!characterBook.containsKey(field)) {
        _lastValidationError = 'data.character_book.$field';
        return false;
      }
    }

    return characterBook['entries'] is List &&
        characterBook['extensions'] is Map;
  }

  bool _validateSpecV3() {
    if (card['spec'] != 'chara_card_v3') {
      _lastValidationError = 'spec';
      return false;
    }
    return true;
  }

  bool _validateSpecVersionV3() {
    final version = num.tryParse(card['spec_version'].toString());
    if (version == null || version < 3.0 || version >= 4.0) {
      _lastValidationError = 'spec_version';
      return false;
    }
    return true;
  }

  bool _validateDataV3() {
    final data = card['data'];

    if (data == null || data is! Map) {
      _lastValidationError = 'No tavern card data found';
      return false;
    }

    return true;
  }
}