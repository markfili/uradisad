// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activism_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivismSourceAuthor _$ActivismSourceAuthorFromJson(Map<String, dynamic> json) {
  return _ActivismSourceAuthor.fromJson(json);
}

/// @nodoc
mixin _$ActivismSourceAuthor {
  String get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this ActivismSourceAuthor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivismSourceAuthorCopyWith<ActivismSourceAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivismSourceAuthorCopyWith<$Res> {
  factory $ActivismSourceAuthorCopyWith(ActivismSourceAuthor value,
          $Res Function(ActivismSourceAuthor) then) =
      _$ActivismSourceAuthorCopyWithImpl<$Res, ActivismSourceAuthor>;
  @useResult
  $Res call({String name, String? url});
}

/// @nodoc
class _$ActivismSourceAuthorCopyWithImpl<$Res,
        $Val extends ActivismSourceAuthor>
    implements $ActivismSourceAuthorCopyWith<$Res> {
  _$ActivismSourceAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivismSourceAuthorImplCopyWith<$Res>
    implements $ActivismSourceAuthorCopyWith<$Res> {
  factory _$$ActivismSourceAuthorImplCopyWith(_$ActivismSourceAuthorImpl value,
          $Res Function(_$ActivismSourceAuthorImpl) then) =
      __$$ActivismSourceAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? url});
}

/// @nodoc
class __$$ActivismSourceAuthorImplCopyWithImpl<$Res>
    extends _$ActivismSourceAuthorCopyWithImpl<$Res, _$ActivismSourceAuthorImpl>
    implements _$$ActivismSourceAuthorImplCopyWith<$Res> {
  __$$ActivismSourceAuthorImplCopyWithImpl(_$ActivismSourceAuthorImpl _value,
      $Res Function(_$ActivismSourceAuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
  }) {
    return _then(_$ActivismSourceAuthorImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivismSourceAuthorImpl implements _ActivismSourceAuthor {
  const _$ActivismSourceAuthorImpl({required this.name, this.url});

  factory _$ActivismSourceAuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivismSourceAuthorImplFromJson(json);

  @override
  final String name;
  @override
  final String? url;

  @override
  String toString() {
    return 'ActivismSourceAuthor(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivismSourceAuthorImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivismSourceAuthorImplCopyWith<_$ActivismSourceAuthorImpl>
      get copyWith =>
          __$$ActivismSourceAuthorImplCopyWithImpl<_$ActivismSourceAuthorImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivismSourceAuthorImplToJson(
      this,
    );
  }
}

abstract class _ActivismSourceAuthor implements ActivismSourceAuthor {
  const factory _ActivismSourceAuthor(
      {required final String name,
      final String? url}) = _$ActivismSourceAuthorImpl;

  factory _ActivismSourceAuthor.fromJson(Map<String, dynamic> json) =
      _$ActivismSourceAuthorImpl.fromJson;

  @override
  String get name;
  @override
  String? get url;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivismSourceAuthorImplCopyWith<_$ActivismSourceAuthorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ActivismSource _$ActivismSourceFromJson(Map<String, dynamic> json) {
  return _ActivismSource.fromJson(json);
}

/// @nodoc
mixin _$ActivismSource {
  String get image => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String get link => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
  List<ActivismCategory> get categories => throw _privateConstructorUsedError;
  ActivismSourceAuthor? get by => throw _privateConstructorUsedError;
  String? get group => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  Map<String, dynamic>? get socials => throw _privateConstructorUsedError;

  /// Serializes this ActivismSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivismSourceCopyWith<ActivismSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivismSourceCopyWith<$Res> {
  factory $ActivismSourceCopyWith(
          ActivismSource value, $Res Function(ActivismSource) then) =
      _$ActivismSourceCopyWithImpl<$Res, ActivismSource>;
  @useResult
  $Res call(
      {String image,
      String title,
      String description,
      @JsonKey(name: 'url') String link,
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      List<ActivismCategory> categories,
      ActivismSourceAuthor? by,
      String? group,
      String? type,
      String? language,
      String? region,
      Map<String, dynamic>? socials});

  $ActivismSourceAuthorCopyWith<$Res>? get by;
}

/// @nodoc
class _$ActivismSourceCopyWithImpl<$Res, $Val extends ActivismSource>
    implements $ActivismSourceCopyWith<$Res> {
  _$ActivismSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? description = null,
    Object? link = null,
    Object? categories = null,
    Object? by = freezed,
    Object? group = freezed,
    Object? type = freezed,
    Object? language = freezed,
    Object? region = freezed,
    Object? socials = freezed,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ActivismCategory>,
      by: freezed == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as ActivismSourceAuthor?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      socials: freezed == socials
          ? _value.socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivismSourceAuthorCopyWith<$Res>? get by {
    if (_value.by == null) {
      return null;
    }

    return $ActivismSourceAuthorCopyWith<$Res>(_value.by!, (value) {
      return _then(_value.copyWith(by: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActivismSourceImplCopyWith<$Res>
    implements $ActivismSourceCopyWith<$Res> {
  factory _$$ActivismSourceImplCopyWith(_$ActivismSourceImpl value,
          $Res Function(_$ActivismSourceImpl) then) =
      __$$ActivismSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String image,
      String title,
      String description,
      @JsonKey(name: 'url') String link,
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      List<ActivismCategory> categories,
      ActivismSourceAuthor? by,
      String? group,
      String? type,
      String? language,
      String? region,
      Map<String, dynamic>? socials});

  @override
  $ActivismSourceAuthorCopyWith<$Res>? get by;
}

/// @nodoc
class __$$ActivismSourceImplCopyWithImpl<$Res>
    extends _$ActivismSourceCopyWithImpl<$Res, _$ActivismSourceImpl>
    implements _$$ActivismSourceImplCopyWith<$Res> {
  __$$ActivismSourceImplCopyWithImpl(
      _$ActivismSourceImpl _value, $Res Function(_$ActivismSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? description = null,
    Object? link = null,
    Object? categories = null,
    Object? by = freezed,
    Object? group = freezed,
    Object? type = freezed,
    Object? language = freezed,
    Object? region = freezed,
    Object? socials = freezed,
  }) {
    return _then(_$ActivismSourceImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ActivismCategory>,
      by: freezed == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as ActivismSourceAuthor?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      socials: freezed == socials
          ? _value._socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivismSourceImpl implements _ActivismSource {
  const _$ActivismSourceImpl(
      {this.image = '',
      this.title = '',
      this.description = '',
      @JsonKey(name: 'url') this.link = '',
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      final List<ActivismCategory> categories = const [],
      this.by,
      this.group,
      this.type,
      this.language,
      this.region,
      final Map<String, dynamic>? socials})
      : _categories = categories,
        _socials = socials;

  factory _$ActivismSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivismSourceImplFromJson(json);

  @override
  @JsonKey()
  final String image;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'url')
  final String link;
  final List<ActivismCategory> _categories;
  @override
  @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
  List<ActivismCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final ActivismSourceAuthor? by;
  @override
  final String? group;
  @override
  final String? type;
  @override
  final String? language;
  @override
  final String? region;
  final Map<String, dynamic>? _socials;
  @override
  Map<String, dynamic>? get socials {
    final value = _socials;
    if (value == null) return null;
    if (_socials is EqualUnmodifiableMapView) return _socials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ActivismSource(image: $image, title: $title, description: $description, link: $link, categories: $categories, by: $by, group: $group, type: $type, language: $language, region: $region, socials: $socials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivismSourceImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality().equals(other._socials, _socials));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      image,
      title,
      description,
      link,
      const DeepCollectionEquality().hash(_categories),
      by,
      group,
      type,
      language,
      region,
      const DeepCollectionEquality().hash(_socials));

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivismSourceImplCopyWith<_$ActivismSourceImpl> get copyWith =>
      __$$ActivismSourceImplCopyWithImpl<_$ActivismSourceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivismSourceImplToJson(
      this,
    );
  }
}

abstract class _ActivismSource implements ActivismSource {
  const factory _ActivismSource(
      {final String image,
      final String title,
      final String description,
      @JsonKey(name: 'url') final String link,
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      final List<ActivismCategory> categories,
      final ActivismSourceAuthor? by,
      final String? group,
      final String? type,
      final String? language,
      final String? region,
      final Map<String, dynamic>? socials}) = _$ActivismSourceImpl;

  factory _ActivismSource.fromJson(Map<String, dynamic> json) =
      _$ActivismSourceImpl.fromJson;

  @override
  String get image;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'url')
  String get link;
  @override
  @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
  List<ActivismCategory> get categories;
  @override
  ActivismSourceAuthor? get by;
  @override
  String? get group;
  @override
  String? get type;
  @override
  String? get language;
  @override
  String? get region;
  @override
  Map<String, dynamic>? get socials;

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivismSourceImplCopyWith<_$ActivismSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
