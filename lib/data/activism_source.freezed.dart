// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activism_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivismSourceAuthor {
  String get name;
  String? get url;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivismSourceAuthorCopyWith<ActivismSourceAuthor> get copyWith =>
      _$ActivismSourceAuthorCopyWithImpl<ActivismSourceAuthor>(
          this as ActivismSourceAuthor, _$identity);

  /// Serializes this ActivismSourceAuthor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActivismSourceAuthor &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @override
  String toString() {
    return 'ActivismSourceAuthor(name: $name, url: $url)';
  }
}

/// @nodoc
abstract mixin class $ActivismSourceAuthorCopyWith<$Res> {
  factory $ActivismSourceAuthorCopyWith(ActivismSourceAuthor value,
          $Res Function(ActivismSourceAuthor) _then) =
      _$ActivismSourceAuthorCopyWithImpl;
  @useResult
  $Res call({String name, String? url});
}

/// @nodoc
class _$ActivismSourceAuthorCopyWithImpl<$Res>
    implements $ActivismSourceAuthorCopyWith<$Res> {
  _$ActivismSourceAuthorCopyWithImpl(this._self, this._then);

  final ActivismSourceAuthor _self;
  final $Res Function(ActivismSourceAuthor) _then;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ActivismSourceAuthor].
extension ActivismSourceAuthorPatterns on ActivismSourceAuthor {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ActivismSourceAuthor value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActivismSourceAuthor() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ActivismSourceAuthor value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSourceAuthor():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ActivismSourceAuthor value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSourceAuthor() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, String? url)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActivismSourceAuthor() when $default != null:
        return $default(_that.name, _that.url);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, String? url) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSourceAuthor():
        return $default(_that.name, _that.url);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String name, String? url)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSourceAuthor() when $default != null:
        return $default(_that.name, _that.url);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ActivismSourceAuthor implements ActivismSourceAuthor {
  const _ActivismSourceAuthor({required this.name, this.url});
  factory _ActivismSourceAuthor.fromJson(Map<String, dynamic> json) =>
      _$ActivismSourceAuthorFromJson(json);

  @override
  final String name;
  @override
  final String? url;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivismSourceAuthorCopyWith<_ActivismSourceAuthor> get copyWith =>
      __$ActivismSourceAuthorCopyWithImpl<_ActivismSourceAuthor>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActivismSourceAuthorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActivismSourceAuthor &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @override
  String toString() {
    return 'ActivismSourceAuthor(name: $name, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$ActivismSourceAuthorCopyWith<$Res>
    implements $ActivismSourceAuthorCopyWith<$Res> {
  factory _$ActivismSourceAuthorCopyWith(_ActivismSourceAuthor value,
          $Res Function(_ActivismSourceAuthor) _then) =
      __$ActivismSourceAuthorCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String? url});
}

/// @nodoc
class __$ActivismSourceAuthorCopyWithImpl<$Res>
    implements _$ActivismSourceAuthorCopyWith<$Res> {
  __$ActivismSourceAuthorCopyWithImpl(this._self, this._then);

  final _ActivismSourceAuthor _self;
  final $Res Function(_ActivismSourceAuthor) _then;

  /// Create a copy of ActivismSourceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? url = freezed,
  }) {
    return _then(_ActivismSourceAuthor(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ActivismSource {
  String get image;
  String get title;
  String get description;
  @JsonKey(name: 'url')
  String get link;
  @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
  List<ActivismCategory> get categories;
  List<String> get paths;
  ActivismSourceAuthor? get by;
  String? get group;
  String? get type;
  String? get language;
  String? get region;
  Map<String, dynamic>? get socials;

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivismSourceCopyWith<ActivismSource> get copyWith =>
      _$ActivismSourceCopyWithImpl<ActivismSource>(
          this as ActivismSource, _$identity);

  /// Serializes this ActivismSource to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActivismSource &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            const DeepCollectionEquality().equals(other.paths, paths) &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.region, region) || other.region == region) &&
            const DeepCollectionEquality().equals(other.socials, socials));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      image,
      title,
      description,
      link,
      const DeepCollectionEquality().hash(categories),
      const DeepCollectionEquality().hash(paths),
      by,
      group,
      type,
      language,
      region,
      const DeepCollectionEquality().hash(socials));

  @override
  String toString() {
    return 'ActivismSource(image: $image, title: $title, description: $description, link: $link, categories: $categories, paths: $paths, by: $by, group: $group, type: $type, language: $language, region: $region, socials: $socials)';
  }
}

/// @nodoc
abstract mixin class $ActivismSourceCopyWith<$Res> {
  factory $ActivismSourceCopyWith(
          ActivismSource value, $Res Function(ActivismSource) _then) =
      _$ActivismSourceCopyWithImpl;
  @useResult
  $Res call(
      {String image,
      String title,
      String description,
      @JsonKey(name: 'url') String link,
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      List<ActivismCategory> categories,
      List<String> paths,
      ActivismSourceAuthor? by,
      String? group,
      String? type,
      String? language,
      String? region,
      Map<String, dynamic>? socials});

  $ActivismSourceAuthorCopyWith<$Res>? get by;
}

/// @nodoc
class _$ActivismSourceCopyWithImpl<$Res>
    implements $ActivismSourceCopyWith<$Res> {
  _$ActivismSourceCopyWithImpl(this._self, this._then);

  final ActivismSource _self;
  final $Res Function(ActivismSource) _then;

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
    Object? paths = null,
    Object? by = freezed,
    Object? group = freezed,
    Object? type = freezed,
    Object? language = freezed,
    Object? region = freezed,
    Object? socials = freezed,
  }) {
    return _then(_self.copyWith(
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ActivismCategory>,
      paths: null == paths
          ? _self.paths
          : paths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      by: freezed == by
          ? _self.by
          : by // ignore: cast_nullable_to_non_nullable
              as ActivismSourceAuthor?,
      group: freezed == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      socials: freezed == socials
          ? _self.socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivismSourceAuthorCopyWith<$Res>? get by {
    if (_self.by == null) {
      return null;
    }

    return $ActivismSourceAuthorCopyWith<$Res>(_self.by!, (value) {
      return _then(_self.copyWith(by: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ActivismSource].
extension ActivismSourcePatterns on ActivismSource {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ActivismSource value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActivismSource() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ActivismSource value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSource():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ActivismSource value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSource() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String image,
            String title,
            String description,
            @JsonKey(name: 'url') String link,
            @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
            List<ActivismCategory> categories,
            List<String> paths,
            ActivismSourceAuthor? by,
            String? group,
            String? type,
            String? language,
            String? region,
            Map<String, dynamic>? socials)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ActivismSource() when $default != null:
        return $default(
            _that.image,
            _that.title,
            _that.description,
            _that.link,
            _that.categories,
            _that.paths,
            _that.by,
            _that.group,
            _that.type,
            _that.language,
            _that.region,
            _that.socials);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String image,
            String title,
            String description,
            @JsonKey(name: 'url') String link,
            @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
            List<ActivismCategory> categories,
            List<String> paths,
            ActivismSourceAuthor? by,
            String? group,
            String? type,
            String? language,
            String? region,
            Map<String, dynamic>? socials)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSource():
        return $default(
            _that.image,
            _that.title,
            _that.description,
            _that.link,
            _that.categories,
            _that.paths,
            _that.by,
            _that.group,
            _that.type,
            _that.language,
            _that.region,
            _that.socials);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String image,
            String title,
            String description,
            @JsonKey(name: 'url') String link,
            @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
            List<ActivismCategory> categories,
            List<String> paths,
            ActivismSourceAuthor? by,
            String? group,
            String? type,
            String? language,
            String? region,
            Map<String, dynamic>? socials)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ActivismSource() when $default != null:
        return $default(
            _that.image,
            _that.title,
            _that.description,
            _that.link,
            _that.categories,
            _that.paths,
            _that.by,
            _that.group,
            _that.type,
            _that.language,
            _that.region,
            _that.socials);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ActivismSource implements ActivismSource {
  const _ActivismSource(
      {this.image = '',
      this.title = '',
      this.description = '',
      @JsonKey(name: 'url') this.link = '',
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      final List<ActivismCategory> categories = const [],
      final List<String> paths = const [],
      this.by,
      this.group,
      this.type,
      this.language,
      this.region,
      final Map<String, dynamic>? socials})
      : _categories = categories,
        _paths = paths,
        _socials = socials;
  factory _ActivismSource.fromJson(Map<String, dynamic> json) =>
      _$ActivismSourceFromJson(json);

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

  final List<String> _paths;
  @override
  @JsonKey()
  List<String> get paths {
    if (_paths is EqualUnmodifiableListView) return _paths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paths);
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

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivismSourceCopyWith<_ActivismSource> get copyWith =>
      __$ActivismSourceCopyWithImpl<_ActivismSource>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActivismSourceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActivismSource &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._paths, _paths) &&
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
      const DeepCollectionEquality().hash(_paths),
      by,
      group,
      type,
      language,
      region,
      const DeepCollectionEquality().hash(_socials));

  @override
  String toString() {
    return 'ActivismSource(image: $image, title: $title, description: $description, link: $link, categories: $categories, paths: $paths, by: $by, group: $group, type: $type, language: $language, region: $region, socials: $socials)';
  }
}

/// @nodoc
abstract mixin class _$ActivismSourceCopyWith<$Res>
    implements $ActivismSourceCopyWith<$Res> {
  factory _$ActivismSourceCopyWith(
          _ActivismSource value, $Res Function(_ActivismSource) _then) =
      __$ActivismSourceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String image,
      String title,
      String description,
      @JsonKey(name: 'url') String link,
      @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson)
      List<ActivismCategory> categories,
      List<String> paths,
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
class __$ActivismSourceCopyWithImpl<$Res>
    implements _$ActivismSourceCopyWith<$Res> {
  __$ActivismSourceCopyWithImpl(this._self, this._then);

  final _ActivismSource _self;
  final $Res Function(_ActivismSource) _then;

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? description = null,
    Object? link = null,
    Object? categories = null,
    Object? paths = null,
    Object? by = freezed,
    Object? group = freezed,
    Object? type = freezed,
    Object? language = freezed,
    Object? region = freezed,
    Object? socials = freezed,
  }) {
    return _then(_ActivismSource(
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<ActivismCategory>,
      paths: null == paths
          ? _self._paths
          : paths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      by: freezed == by
          ? _self.by
          : by // ignore: cast_nullable_to_non_nullable
              as ActivismSourceAuthor?,
      group: freezed == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _self.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      socials: freezed == socials
          ? _self._socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }

  /// Create a copy of ActivismSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivismSourceAuthorCopyWith<$Res>? get by {
    if (_self.by == null) {
      return null;
    }

    return $ActivismSourceAuthorCopyWith<$Res>(_self.by!, (value) {
      return _then(_self.copyWith(by: value));
    });
  }
}

// dart format on
