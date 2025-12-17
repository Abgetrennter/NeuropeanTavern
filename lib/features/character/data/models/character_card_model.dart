// ignore_for_file: invalid_annotation_target
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

    /// 示例对话 (Example Dialogue)
    /// 用于展示角色的说话风格和语气。
    /// 使用 @Default('') 替代 required，防止因字段缺失导致解析崩溃。
    @JsonKey(name: 'mes_example') @Default('') String mesExample,

    /// 作者备注 (Creator Notes)
    /// 包含角色的使用说明或背景设定。
    @JsonKey(name: 'creator_notes') String? creatorNotes,

    /// 系统提示词 (System Prompt)
    /// 针对该角色的特殊系统指令。
    /// 保留为可空 (String?)，以便区分“无特殊指令(null)”和“空指令('')”。
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