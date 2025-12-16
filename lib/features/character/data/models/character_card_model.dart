import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_card_model.freezed.dart';
part 'character_card_model.g.dart';

@freezed
class CharacterCardModel with _$CharacterCardModel {
  const factory CharacterCardModel({
    // V2 Fields
    required String name,
    required String description,
    required String personality,
    required String scenario,
    @JsonKey(name: 'first_mes') required String firstMes,
    @JsonKey(name: 'mes_example') required String mesExample,
    @JsonKey(name: 'creator_notes') String? creatorNotes,
    @JsonKey(name: 'system_prompt') String? systemPrompt,
    @JsonKey(name: 'post_history_instructions') String? postHistoryInstructions,
    @JsonKey(name: 'alternate_greetings') List<String>? alternateGreetings,
    List<String>? tags,
    String? creator,
    @JsonKey(name: 'character_version') String? characterVersion,
    Map<String, dynamic>? extensions,
    @JsonKey(name: 'character_book') Map<String, dynamic>? characterBook,

    // V3 New Fields
    String? nickname,
    @JsonKey(name: 'creator_notes_multilingual') Map<String, String>? creatorNotesMultilingual,
    List<String>? source,
    @JsonKey(name: 'group_only_greetings') List<String>? groupOnlyGreetings,
    @JsonKey(name: 'creation_date') int? creationDate,
    @JsonKey(name: 'modification_date') int? modificationDate,
    List<CharacterCardAsset>? assets,
  }) = _CharacterCardModel;

  factory CharacterCardModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterCardModelFromJson(json);
}

@freezed
class CharacterCardAsset with _$CharacterCardAsset {
  const factory CharacterCardAsset({
    required String type,
    required String uri,
    required String name,
    required String ext,
  }) = _CharacterCardAsset;

  factory CharacterCardAsset.fromJson(Map<String, dynamic> json) =>
      _$CharacterCardAssetFromJson(json);
}

@freezed
class CharacterCard with _$CharacterCard {
  const factory CharacterCard({
    required String spec,
    @JsonKey(name: 'spec_version') required String specVersion,
    required CharacterCardModel data,
  }) = _CharacterCard;

  factory CharacterCard.fromJson(Map<String, dynamic> json) =>
      _$CharacterCardFromJson(json);
}