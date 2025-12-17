// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CharacterCardModel _$CharacterCardModelFromJson(Map<String, dynamic> json) {
  return _CharacterCardModel.fromJson(json);
}

/// @nodoc
mixin _$CharacterCardModel {
  // V2 Fields
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get personality => throw _privateConstructorUsedError;
  String get scenario => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_mes')
  String get firstMes => throw _privateConstructorUsedError;

  /// 示例对话 (Example Dialogue)
  /// 用于展示角色的说话风格和语气。
  /// 使用 @Default('') 替代 required，防止因字段缺失导致解析崩溃。
  @JsonKey(name: 'mes_example')
  String get mesExample => throw _privateConstructorUsedError;

  /// 作者备注 (Creator Notes)
  /// 包含角色的使用说明或背景设定。
  @JsonKey(name: 'creator_notes')
  String? get creatorNotes => throw _privateConstructorUsedError;

  /// 系统提示词 (System Prompt)
  /// 针对该角色的特殊系统指令。
  /// 保留为可空 (String?)，以便区分“无特殊指令(null)”和“空指令('')”。
  @JsonKey(name: 'system_prompt')
  String? get systemPrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_history_instructions')
  String? get postHistoryInstructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'alternate_greetings')
  List<String>? get alternateGreetings => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get creator => throw _privateConstructorUsedError;
  @JsonKey(name: 'character_version')
  String? get characterVersion => throw _privateConstructorUsedError;
  Map<String, dynamic>? get extensions => throw _privateConstructorUsedError;
  @JsonKey(name: 'character_book')
  Map<String, dynamic>? get characterBook => throw _privateConstructorUsedError; // V3 New Fields
  String? get nickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator_notes_multilingual')
  Map<String, String>? get creatorNotesMultilingual =>
      throw _privateConstructorUsedError;
  List<String>? get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_only_greetings')
  List<String>? get groupOnlyGreetings => throw _privateConstructorUsedError;
  @JsonKey(name: 'creation_date')
  int? get creationDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'modification_date')
  int? get modificationDate => throw _privateConstructorUsedError;
  List<CharacterCardAsset>? get assets => throw _privateConstructorUsedError;

  /// Serializes this CharacterCardModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterCardModelCopyWith<CharacterCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCardModelCopyWith<$Res> {
  factory $CharacterCardModelCopyWith(
    CharacterCardModel value,
    $Res Function(CharacterCardModel) then,
  ) = _$CharacterCardModelCopyWithImpl<$Res, CharacterCardModel>;
  @useResult
  $Res call({
    String name,
    String description,
    String personality,
    String scenario,
    @JsonKey(name: 'first_mes') String firstMes,
    @JsonKey(name: 'mes_example') String mesExample,
    @JsonKey(name: 'creator_notes') String? creatorNotes,
    @JsonKey(name: 'system_prompt') String? systemPrompt,
    @JsonKey(name: 'post_history_instructions') String? postHistoryInstructions,
    @JsonKey(name: 'alternate_greetings') List<String>? alternateGreetings,
    List<String>? tags,
    String? creator,
    @JsonKey(name: 'character_version') String? characterVersion,
    Map<String, dynamic>? extensions,
    @JsonKey(name: 'character_book') Map<String, dynamic>? characterBook,
    String? nickname,
    @JsonKey(name: 'creator_notes_multilingual')
    Map<String, String>? creatorNotesMultilingual,
    List<String>? source,
    @JsonKey(name: 'group_only_greetings') List<String>? groupOnlyGreetings,
    @JsonKey(name: 'creation_date') int? creationDate,
    @JsonKey(name: 'modification_date') int? modificationDate,
    List<CharacterCardAsset>? assets,
  });
}

/// @nodoc
class _$CharacterCardModelCopyWithImpl<$Res, $Val extends CharacterCardModel>
    implements $CharacterCardModelCopyWith<$Res> {
  _$CharacterCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? personality = null,
    Object? scenario = null,
    Object? firstMes = null,
    Object? mesExample = null,
    Object? creatorNotes = freezed,
    Object? systemPrompt = freezed,
    Object? postHistoryInstructions = freezed,
    Object? alternateGreetings = freezed,
    Object? tags = freezed,
    Object? creator = freezed,
    Object? characterVersion = freezed,
    Object? extensions = freezed,
    Object? characterBook = freezed,
    Object? nickname = freezed,
    Object? creatorNotesMultilingual = freezed,
    Object? source = freezed,
    Object? groupOnlyGreetings = freezed,
    Object? creationDate = freezed,
    Object? modificationDate = freezed,
    Object? assets = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            personality: null == personality
                ? _value.personality
                : personality // ignore: cast_nullable_to_non_nullable
                      as String,
            scenario: null == scenario
                ? _value.scenario
                : scenario // ignore: cast_nullable_to_non_nullable
                      as String,
            firstMes: null == firstMes
                ? _value.firstMes
                : firstMes // ignore: cast_nullable_to_non_nullable
                      as String,
            mesExample: null == mesExample
                ? _value.mesExample
                : mesExample // ignore: cast_nullable_to_non_nullable
                      as String,
            creatorNotes: freezed == creatorNotes
                ? _value.creatorNotes
                : creatorNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemPrompt: freezed == systemPrompt
                ? _value.systemPrompt
                : systemPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
            postHistoryInstructions: freezed == postHistoryInstructions
                ? _value.postHistoryInstructions
                : postHistoryInstructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            alternateGreetings: freezed == alternateGreetings
                ? _value.alternateGreetings
                : alternateGreetings // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            creator: freezed == creator
                ? _value.creator
                : creator // ignore: cast_nullable_to_non_nullable
                      as String?,
            characterVersion: freezed == characterVersion
                ? _value.characterVersion
                : characterVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            extensions: freezed == extensions
                ? _value.extensions
                : extensions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            characterBook: freezed == characterBook
                ? _value.characterBook
                : characterBook // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            nickname: freezed == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            creatorNotesMultilingual: freezed == creatorNotesMultilingual
                ? _value.creatorNotesMultilingual
                : creatorNotesMultilingual // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            groupOnlyGreetings: freezed == groupOnlyGreetings
                ? _value.groupOnlyGreetings
                : groupOnlyGreetings // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            creationDate: freezed == creationDate
                ? _value.creationDate
                : creationDate // ignore: cast_nullable_to_non_nullable
                      as int?,
            modificationDate: freezed == modificationDate
                ? _value.modificationDate
                : modificationDate // ignore: cast_nullable_to_non_nullable
                      as int?,
            assets: freezed == assets
                ? _value.assets
                : assets // ignore: cast_nullable_to_non_nullable
                      as List<CharacterCardAsset>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterCardModelImplCopyWith<$Res>
    implements $CharacterCardModelCopyWith<$Res> {
  factory _$$CharacterCardModelImplCopyWith(
    _$CharacterCardModelImpl value,
    $Res Function(_$CharacterCardModelImpl) then,
  ) = __$$CharacterCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String description,
    String personality,
    String scenario,
    @JsonKey(name: 'first_mes') String firstMes,
    @JsonKey(name: 'mes_example') String mesExample,
    @JsonKey(name: 'creator_notes') String? creatorNotes,
    @JsonKey(name: 'system_prompt') String? systemPrompt,
    @JsonKey(name: 'post_history_instructions') String? postHistoryInstructions,
    @JsonKey(name: 'alternate_greetings') List<String>? alternateGreetings,
    List<String>? tags,
    String? creator,
    @JsonKey(name: 'character_version') String? characterVersion,
    Map<String, dynamic>? extensions,
    @JsonKey(name: 'character_book') Map<String, dynamic>? characterBook,
    String? nickname,
    @JsonKey(name: 'creator_notes_multilingual')
    Map<String, String>? creatorNotesMultilingual,
    List<String>? source,
    @JsonKey(name: 'group_only_greetings') List<String>? groupOnlyGreetings,
    @JsonKey(name: 'creation_date') int? creationDate,
    @JsonKey(name: 'modification_date') int? modificationDate,
    List<CharacterCardAsset>? assets,
  });
}

/// @nodoc
class __$$CharacterCardModelImplCopyWithImpl<$Res>
    extends _$CharacterCardModelCopyWithImpl<$Res, _$CharacterCardModelImpl>
    implements _$$CharacterCardModelImplCopyWith<$Res> {
  __$$CharacterCardModelImplCopyWithImpl(
    _$CharacterCardModelImpl _value,
    $Res Function(_$CharacterCardModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterCardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? personality = null,
    Object? scenario = null,
    Object? firstMes = null,
    Object? mesExample = null,
    Object? creatorNotes = freezed,
    Object? systemPrompt = freezed,
    Object? postHistoryInstructions = freezed,
    Object? alternateGreetings = freezed,
    Object? tags = freezed,
    Object? creator = freezed,
    Object? characterVersion = freezed,
    Object? extensions = freezed,
    Object? characterBook = freezed,
    Object? nickname = freezed,
    Object? creatorNotesMultilingual = freezed,
    Object? source = freezed,
    Object? groupOnlyGreetings = freezed,
    Object? creationDate = freezed,
    Object? modificationDate = freezed,
    Object? assets = freezed,
  }) {
    return _then(
      _$CharacterCardModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        personality: null == personality
            ? _value.personality
            : personality // ignore: cast_nullable_to_non_nullable
                  as String,
        scenario: null == scenario
            ? _value.scenario
            : scenario // ignore: cast_nullable_to_non_nullable
                  as String,
        firstMes: null == firstMes
            ? _value.firstMes
            : firstMes // ignore: cast_nullable_to_non_nullable
                  as String,
        mesExample: null == mesExample
            ? _value.mesExample
            : mesExample // ignore: cast_nullable_to_non_nullable
                  as String,
        creatorNotes: freezed == creatorNotes
            ? _value.creatorNotes
            : creatorNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemPrompt: freezed == systemPrompt
            ? _value.systemPrompt
            : systemPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
        postHistoryInstructions: freezed == postHistoryInstructions
            ? _value.postHistoryInstructions
            : postHistoryInstructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        alternateGreetings: freezed == alternateGreetings
            ? _value._alternateGreetings
            : alternateGreetings // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        creator: freezed == creator
            ? _value.creator
            : creator // ignore: cast_nullable_to_non_nullable
                  as String?,
        characterVersion: freezed == characterVersion
            ? _value.characterVersion
            : characterVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        extensions: freezed == extensions
            ? _value._extensions
            : extensions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        characterBook: freezed == characterBook
            ? _value._characterBook
            : characterBook // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        nickname: freezed == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        creatorNotesMultilingual: freezed == creatorNotesMultilingual
            ? _value._creatorNotesMultilingual
            : creatorNotesMultilingual // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        source: freezed == source
            ? _value._source
            : source // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        groupOnlyGreetings: freezed == groupOnlyGreetings
            ? _value._groupOnlyGreetings
            : groupOnlyGreetings // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        creationDate: freezed == creationDate
            ? _value.creationDate
            : creationDate // ignore: cast_nullable_to_non_nullable
                  as int?,
        modificationDate: freezed == modificationDate
            ? _value.modificationDate
            : modificationDate // ignore: cast_nullable_to_non_nullable
                  as int?,
        assets: freezed == assets
            ? _value._assets
            : assets // ignore: cast_nullable_to_non_nullable
                  as List<CharacterCardAsset>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterCardModelImpl implements _CharacterCardModel {
  const _$CharacterCardModelImpl({
    required this.name,
    required this.description,
    required this.personality,
    required this.scenario,
    @JsonKey(name: 'first_mes') required this.firstMes,
    @JsonKey(name: 'mes_example') this.mesExample = '',
    @JsonKey(name: 'creator_notes') this.creatorNotes,
    @JsonKey(name: 'system_prompt') this.systemPrompt,
    @JsonKey(name: 'post_history_instructions') this.postHistoryInstructions,
    @JsonKey(name: 'alternate_greetings')
    final List<String>? alternateGreetings,
    final List<String>? tags,
    this.creator,
    @JsonKey(name: 'character_version') this.characterVersion,
    final Map<String, dynamic>? extensions,
    @JsonKey(name: 'character_book') final Map<String, dynamic>? characterBook,
    this.nickname,
    @JsonKey(name: 'creator_notes_multilingual')
    final Map<String, String>? creatorNotesMultilingual,
    final List<String>? source,
    @JsonKey(name: 'group_only_greetings')
    final List<String>? groupOnlyGreetings,
    @JsonKey(name: 'creation_date') this.creationDate,
    @JsonKey(name: 'modification_date') this.modificationDate,
    final List<CharacterCardAsset>? assets,
  }) : _alternateGreetings = alternateGreetings,
       _tags = tags,
       _extensions = extensions,
       _characterBook = characterBook,
       _creatorNotesMultilingual = creatorNotesMultilingual,
       _source = source,
       _groupOnlyGreetings = groupOnlyGreetings,
       _assets = assets;

  factory _$CharacterCardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterCardModelImplFromJson(json);

  // V2 Fields
  @override
  final String name;
  @override
  final String description;
  @override
  final String personality;
  @override
  final String scenario;
  @override
  @JsonKey(name: 'first_mes')
  final String firstMes;

  /// 示例对话 (Example Dialogue)
  /// 用于展示角色的说话风格和语气。
  /// 使用 @Default('') 替代 required，防止因字段缺失导致解析崩溃。
  @override
  @JsonKey(name: 'mes_example')
  final String mesExample;

  /// 作者备注 (Creator Notes)
  /// 包含角色的使用说明或背景设定。
  @override
  @JsonKey(name: 'creator_notes')
  final String? creatorNotes;

  /// 系统提示词 (System Prompt)
  /// 针对该角色的特殊系统指令。
  /// 保留为可空 (String?)，以便区分“无特殊指令(null)”和“空指令('')”。
  @override
  @JsonKey(name: 'system_prompt')
  final String? systemPrompt;
  @override
  @JsonKey(name: 'post_history_instructions')
  final String? postHistoryInstructions;
  final List<String>? _alternateGreetings;
  @override
  @JsonKey(name: 'alternate_greetings')
  List<String>? get alternateGreetings {
    final value = _alternateGreetings;
    if (value == null) return null;
    if (_alternateGreetings is EqualUnmodifiableListView)
      return _alternateGreetings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? creator;
  @override
  @JsonKey(name: 'character_version')
  final String? characterVersion;
  final Map<String, dynamic>? _extensions;
  @override
  Map<String, dynamic>? get extensions {
    final value = _extensions;
    if (value == null) return null;
    if (_extensions is EqualUnmodifiableMapView) return _extensions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _characterBook;
  @override
  @JsonKey(name: 'character_book')
  Map<String, dynamic>? get characterBook {
    final value = _characterBook;
    if (value == null) return null;
    if (_characterBook is EqualUnmodifiableMapView) return _characterBook;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  // V3 New Fields
  @override
  final String? nickname;
  final Map<String, String>? _creatorNotesMultilingual;
  @override
  @JsonKey(name: 'creator_notes_multilingual')
  Map<String, String>? get creatorNotesMultilingual {
    final value = _creatorNotesMultilingual;
    if (value == null) return null;
    if (_creatorNotesMultilingual is EqualUnmodifiableMapView)
      return _creatorNotesMultilingual;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _source;
  @override
  List<String>? get source {
    final value = _source;
    if (value == null) return null;
    if (_source is EqualUnmodifiableListView) return _source;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _groupOnlyGreetings;
  @override
  @JsonKey(name: 'group_only_greetings')
  List<String>? get groupOnlyGreetings {
    final value = _groupOnlyGreetings;
    if (value == null) return null;
    if (_groupOnlyGreetings is EqualUnmodifiableListView)
      return _groupOnlyGreetings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'creation_date')
  final int? creationDate;
  @override
  @JsonKey(name: 'modification_date')
  final int? modificationDate;
  final List<CharacterCardAsset>? _assets;
  @override
  List<CharacterCardAsset>? get assets {
    final value = _assets;
    if (value == null) return null;
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CharacterCardModel(name: $name, description: $description, personality: $personality, scenario: $scenario, firstMes: $firstMes, mesExample: $mesExample, creatorNotes: $creatorNotes, systemPrompt: $systemPrompt, postHistoryInstructions: $postHistoryInstructions, alternateGreetings: $alternateGreetings, tags: $tags, creator: $creator, characterVersion: $characterVersion, extensions: $extensions, characterBook: $characterBook, nickname: $nickname, creatorNotesMultilingual: $creatorNotesMultilingual, source: $source, groupOnlyGreetings: $groupOnlyGreetings, creationDate: $creationDate, modificationDate: $modificationDate, assets: $assets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterCardModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.personality, personality) ||
                other.personality == personality) &&
            (identical(other.scenario, scenario) ||
                other.scenario == scenario) &&
            (identical(other.firstMes, firstMes) ||
                other.firstMes == firstMes) &&
            (identical(other.mesExample, mesExample) ||
                other.mesExample == mesExample) &&
            (identical(other.creatorNotes, creatorNotes) ||
                other.creatorNotes == creatorNotes) &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(
                  other.postHistoryInstructions,
                  postHistoryInstructions,
                ) ||
                other.postHistoryInstructions == postHistoryInstructions) &&
            const DeepCollectionEquality().equals(
              other._alternateGreetings,
              _alternateGreetings,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.characterVersion, characterVersion) ||
                other.characterVersion == characterVersion) &&
            const DeepCollectionEquality().equals(
              other._extensions,
              _extensions,
            ) &&
            const DeepCollectionEquality().equals(
              other._characterBook,
              _characterBook,
            ) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality().equals(
              other._creatorNotesMultilingual,
              _creatorNotesMultilingual,
            ) &&
            const DeepCollectionEquality().equals(other._source, _source) &&
            const DeepCollectionEquality().equals(
              other._groupOnlyGreetings,
              _groupOnlyGreetings,
            ) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.modificationDate, modificationDate) ||
                other.modificationDate == modificationDate) &&
            const DeepCollectionEquality().equals(other._assets, _assets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    name,
    description,
    personality,
    scenario,
    firstMes,
    mesExample,
    creatorNotes,
    systemPrompt,
    postHistoryInstructions,
    const DeepCollectionEquality().hash(_alternateGreetings),
    const DeepCollectionEquality().hash(_tags),
    creator,
    characterVersion,
    const DeepCollectionEquality().hash(_extensions),
    const DeepCollectionEquality().hash(_characterBook),
    nickname,
    const DeepCollectionEquality().hash(_creatorNotesMultilingual),
    const DeepCollectionEquality().hash(_source),
    const DeepCollectionEquality().hash(_groupOnlyGreetings),
    creationDate,
    modificationDate,
    const DeepCollectionEquality().hash(_assets),
  ]);

  /// Create a copy of CharacterCardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterCardModelImplCopyWith<_$CharacterCardModelImpl> get copyWith =>
      __$$CharacterCardModelImplCopyWithImpl<_$CharacterCardModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterCardModelImplToJson(this);
  }
}

abstract class _CharacterCardModel implements CharacterCardModel {
  const factory _CharacterCardModel({
    required final String name,
    required final String description,
    required final String personality,
    required final String scenario,
    @JsonKey(name: 'first_mes') required final String firstMes,
    @JsonKey(name: 'mes_example') final String mesExample,
    @JsonKey(name: 'creator_notes') final String? creatorNotes,
    @JsonKey(name: 'system_prompt') final String? systemPrompt,
    @JsonKey(name: 'post_history_instructions')
    final String? postHistoryInstructions,
    @JsonKey(name: 'alternate_greetings')
    final List<String>? alternateGreetings,
    final List<String>? tags,
    final String? creator,
    @JsonKey(name: 'character_version') final String? characterVersion,
    final Map<String, dynamic>? extensions,
    @JsonKey(name: 'character_book') final Map<String, dynamic>? characterBook,
    final String? nickname,
    @JsonKey(name: 'creator_notes_multilingual')
    final Map<String, String>? creatorNotesMultilingual,
    final List<String>? source,
    @JsonKey(name: 'group_only_greetings')
    final List<String>? groupOnlyGreetings,
    @JsonKey(name: 'creation_date') final int? creationDate,
    @JsonKey(name: 'modification_date') final int? modificationDate,
    final List<CharacterCardAsset>? assets,
  }) = _$CharacterCardModelImpl;

  factory _CharacterCardModel.fromJson(Map<String, dynamic> json) =
      _$CharacterCardModelImpl.fromJson;

  // V2 Fields
  @override
  String get name;
  @override
  String get description;
  @override
  String get personality;
  @override
  String get scenario;
  @override
  @JsonKey(name: 'first_mes')
  String get firstMes;

  /// 示例对话 (Example Dialogue)
  /// 用于展示角色的说话风格和语气。
  /// 使用 @Default('') 替代 required，防止因字段缺失导致解析崩溃。
  @override
  @JsonKey(name: 'mes_example')
  String get mesExample;

  /// 作者备注 (Creator Notes)
  /// 包含角色的使用说明或背景设定。
  @override
  @JsonKey(name: 'creator_notes')
  String? get creatorNotes;

  /// 系统提示词 (System Prompt)
  /// 针对该角色的特殊系统指令。
  /// 保留为可空 (String?)，以便区分“无特殊指令(null)”和“空指令('')”。
  @override
  @JsonKey(name: 'system_prompt')
  String? get systemPrompt;
  @override
  @JsonKey(name: 'post_history_instructions')
  String? get postHistoryInstructions;
  @override
  @JsonKey(name: 'alternate_greetings')
  List<String>? get alternateGreetings;
  @override
  List<String>? get tags;
  @override
  String? get creator;
  @override
  @JsonKey(name: 'character_version')
  String? get characterVersion;
  @override
  Map<String, dynamic>? get extensions;
  @override
  @JsonKey(name: 'character_book')
  Map<String, dynamic>? get characterBook; // V3 New Fields
  @override
  String? get nickname;
  @override
  @JsonKey(name: 'creator_notes_multilingual')
  Map<String, String>? get creatorNotesMultilingual;
  @override
  List<String>? get source;
  @override
  @JsonKey(name: 'group_only_greetings')
  List<String>? get groupOnlyGreetings;
  @override
  @JsonKey(name: 'creation_date')
  int? get creationDate;
  @override
  @JsonKey(name: 'modification_date')
  int? get modificationDate;
  @override
  List<CharacterCardAsset>? get assets;

  /// Create a copy of CharacterCardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterCardModelImplCopyWith<_$CharacterCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterCardAsset _$CharacterCardAssetFromJson(Map<String, dynamic> json) {
  return _CharacterCardAsset.fromJson(json);
}

/// @nodoc
mixin _$CharacterCardAsset {
  String get type => throw _privateConstructorUsedError;
  String get uri => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get ext => throw _privateConstructorUsedError;

  /// Serializes this CharacterCardAsset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterCardAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterCardAssetCopyWith<CharacterCardAsset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCardAssetCopyWith<$Res> {
  factory $CharacterCardAssetCopyWith(
    CharacterCardAsset value,
    $Res Function(CharacterCardAsset) then,
  ) = _$CharacterCardAssetCopyWithImpl<$Res, CharacterCardAsset>;
  @useResult
  $Res call({String type, String uri, String name, String ext});
}

/// @nodoc
class _$CharacterCardAssetCopyWithImpl<$Res, $Val extends CharacterCardAsset>
    implements $CharacterCardAssetCopyWith<$Res> {
  _$CharacterCardAssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterCardAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? uri = null,
    Object? name = null,
    Object? ext = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            uri: null == uri
                ? _value.uri
                : uri // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            ext: null == ext
                ? _value.ext
                : ext // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterCardAssetImplCopyWith<$Res>
    implements $CharacterCardAssetCopyWith<$Res> {
  factory _$$CharacterCardAssetImplCopyWith(
    _$CharacterCardAssetImpl value,
    $Res Function(_$CharacterCardAssetImpl) then,
  ) = __$$CharacterCardAssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String uri, String name, String ext});
}

/// @nodoc
class __$$CharacterCardAssetImplCopyWithImpl<$Res>
    extends _$CharacterCardAssetCopyWithImpl<$Res, _$CharacterCardAssetImpl>
    implements _$$CharacterCardAssetImplCopyWith<$Res> {
  __$$CharacterCardAssetImplCopyWithImpl(
    _$CharacterCardAssetImpl _value,
    $Res Function(_$CharacterCardAssetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterCardAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? uri = null,
    Object? name = null,
    Object? ext = null,
  }) {
    return _then(
      _$CharacterCardAssetImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        uri: null == uri
            ? _value.uri
            : uri // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        ext: null == ext
            ? _value.ext
            : ext // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterCardAssetImpl implements _CharacterCardAsset {
  const _$CharacterCardAssetImpl({
    required this.type,
    required this.uri,
    required this.name,
    required this.ext,
  });

  factory _$CharacterCardAssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterCardAssetImplFromJson(json);

  @override
  final String type;
  @override
  final String uri;
  @override
  final String name;
  @override
  final String ext;

  @override
  String toString() {
    return 'CharacterCardAsset(type: $type, uri: $uri, name: $name, ext: $ext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterCardAssetImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ext, ext) || other.ext == ext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, uri, name, ext);

  /// Create a copy of CharacterCardAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterCardAssetImplCopyWith<_$CharacterCardAssetImpl> get copyWith =>
      __$$CharacterCardAssetImplCopyWithImpl<_$CharacterCardAssetImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterCardAssetImplToJson(this);
  }
}

abstract class _CharacterCardAsset implements CharacterCardAsset {
  const factory _CharacterCardAsset({
    required final String type,
    required final String uri,
    required final String name,
    required final String ext,
  }) = _$CharacterCardAssetImpl;

  factory _CharacterCardAsset.fromJson(Map<String, dynamic> json) =
      _$CharacterCardAssetImpl.fromJson;

  @override
  String get type;
  @override
  String get uri;
  @override
  String get name;
  @override
  String get ext;

  /// Create a copy of CharacterCardAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterCardAssetImplCopyWith<_$CharacterCardAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterCard _$CharacterCardFromJson(Map<String, dynamic> json) {
  return _CharacterCard.fromJson(json);
}

/// @nodoc
mixin _$CharacterCard {
  String get spec => throw _privateConstructorUsedError;
  @JsonKey(name: 'spec_version')
  String get specVersion => throw _privateConstructorUsedError;
  CharacterCardModel get data => throw _privateConstructorUsedError;

  /// Serializes this CharacterCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterCardCopyWith<CharacterCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCardCopyWith<$Res> {
  factory $CharacterCardCopyWith(
    CharacterCard value,
    $Res Function(CharacterCard) then,
  ) = _$CharacterCardCopyWithImpl<$Res, CharacterCard>;
  @useResult
  $Res call({
    String spec,
    @JsonKey(name: 'spec_version') String specVersion,
    CharacterCardModel data,
  });

  $CharacterCardModelCopyWith<$Res> get data;
}

/// @nodoc
class _$CharacterCardCopyWithImpl<$Res, $Val extends CharacterCard>
    implements $CharacterCardCopyWith<$Res> {
  _$CharacterCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spec = null,
    Object? specVersion = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            spec: null == spec
                ? _value.spec
                : spec // ignore: cast_nullable_to_non_nullable
                      as String,
            specVersion: null == specVersion
                ? _value.specVersion
                : specVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as CharacterCardModel,
          )
          as $Val,
    );
  }

  /// Create a copy of CharacterCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterCardModelCopyWith<$Res> get data {
    return $CharacterCardModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharacterCardImplCopyWith<$Res>
    implements $CharacterCardCopyWith<$Res> {
  factory _$$CharacterCardImplCopyWith(
    _$CharacterCardImpl value,
    $Res Function(_$CharacterCardImpl) then,
  ) = __$$CharacterCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String spec,
    @JsonKey(name: 'spec_version') String specVersion,
    CharacterCardModel data,
  });

  @override
  $CharacterCardModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$CharacterCardImplCopyWithImpl<$Res>
    extends _$CharacterCardCopyWithImpl<$Res, _$CharacterCardImpl>
    implements _$$CharacterCardImplCopyWith<$Res> {
  __$$CharacterCardImplCopyWithImpl(
    _$CharacterCardImpl _value,
    $Res Function(_$CharacterCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spec = null,
    Object? specVersion = null,
    Object? data = null,
  }) {
    return _then(
      _$CharacterCardImpl(
        spec: null == spec
            ? _value.spec
            : spec // ignore: cast_nullable_to_non_nullable
                  as String,
        specVersion: null == specVersion
            ? _value.specVersion
            : specVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as CharacterCardModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterCardImpl implements _CharacterCard {
  const _$CharacterCardImpl({
    required this.spec,
    @JsonKey(name: 'spec_version') required this.specVersion,
    required this.data,
  });

  factory _$CharacterCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterCardImplFromJson(json);

  @override
  final String spec;
  @override
  @JsonKey(name: 'spec_version')
  final String specVersion;
  @override
  final CharacterCardModel data;

  @override
  String toString() {
    return 'CharacterCard(spec: $spec, specVersion: $specVersion, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterCardImpl &&
            (identical(other.spec, spec) || other.spec == spec) &&
            (identical(other.specVersion, specVersion) ||
                other.specVersion == specVersion) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, spec, specVersion, data);

  /// Create a copy of CharacterCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterCardImplCopyWith<_$CharacterCardImpl> get copyWith =>
      __$$CharacterCardImplCopyWithImpl<_$CharacterCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterCardImplToJson(this);
  }
}

abstract class _CharacterCard implements CharacterCard {
  const factory _CharacterCard({
    required final String spec,
    @JsonKey(name: 'spec_version') required final String specVersion,
    required final CharacterCardModel data,
  }) = _$CharacterCardImpl;

  factory _CharacterCard.fromJson(Map<String, dynamic> json) =
      _$CharacterCardImpl.fromJson;

  @override
  String get spec;
  @override
  @JsonKey(name: 'spec_version')
  String get specVersion;
  @override
  CharacterCardModel get data;

  /// Create a copy of CharacterCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterCardImplCopyWith<_$CharacterCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
