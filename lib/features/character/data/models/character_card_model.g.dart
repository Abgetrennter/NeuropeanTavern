// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterCardModelImpl _$$CharacterCardModelImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterCardModelImpl(
  name: json['name'] as String,
  description: json['description'] as String,
  personality: json['personality'] as String,
  scenario: json['scenario'] as String,
  firstMes: json['first_mes'] as String,
  mesExample: json['mes_example'] as String,
  creatorNotes: json['creator_notes'] as String?,
  systemPrompt: json['system_prompt'] as String?,
  postHistoryInstructions: json['post_history_instructions'] as String?,
  alternateGreetings: (json['alternate_greetings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  creator: json['creator'] as String?,
  characterVersion: json['character_version'] as String?,
  extensions: json['extensions'] as Map<String, dynamic>?,
  characterBook: json['character_book'] as Map<String, dynamic>?,
  nickname: json['nickname'] as String?,
  creatorNotesMultilingual:
      (json['creator_notes_multilingual'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
  source: (json['source'] as List<dynamic>?)?.map((e) => e as String).toList(),
  groupOnlyGreetings: (json['group_only_greetings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  creationDate: (json['creation_date'] as num?)?.toInt(),
  modificationDate: (json['modification_date'] as num?)?.toInt(),
  assets: (json['assets'] as List<dynamic>?)
      ?.map((e) => CharacterCardAsset.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CharacterCardModelImplToJson(
  _$CharacterCardModelImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'personality': instance.personality,
  'scenario': instance.scenario,
  'first_mes': instance.firstMes,
  'mes_example': instance.mesExample,
  'creator_notes': instance.creatorNotes,
  'system_prompt': instance.systemPrompt,
  'post_history_instructions': instance.postHistoryInstructions,
  'alternate_greetings': instance.alternateGreetings,
  'tags': instance.tags,
  'creator': instance.creator,
  'character_version': instance.characterVersion,
  'extensions': instance.extensions,
  'character_book': instance.characterBook,
  'nickname': instance.nickname,
  'creator_notes_multilingual': instance.creatorNotesMultilingual,
  'source': instance.source,
  'group_only_greetings': instance.groupOnlyGreetings,
  'creation_date': instance.creationDate,
  'modification_date': instance.modificationDate,
  'assets': instance.assets,
};

_$CharacterCardAssetImpl _$$CharacterCardAssetImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterCardAssetImpl(
  type: json['type'] as String,
  uri: json['uri'] as String,
  name: json['name'] as String,
  ext: json['ext'] as String,
);

Map<String, dynamic> _$$CharacterCardAssetImplToJson(
  _$CharacterCardAssetImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'uri': instance.uri,
  'name': instance.name,
  'ext': instance.ext,
};

_$CharacterCardImpl _$$CharacterCardImplFromJson(Map<String, dynamic> json) =>
    _$CharacterCardImpl(
      spec: json['spec'] as String,
      specVersion: json['spec_version'] as String,
      data: CharacterCardModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CharacterCardImplToJson(_$CharacterCardImpl instance) =>
    <String, dynamic>{
      'spec': instance.spec,
      'spec_version': instance.specVersion,
      'data': instance.data,
    };
