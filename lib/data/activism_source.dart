import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activism_source.freezed.dart';
part 'activism_source.g.dart';

List<ActivismCategory> _categoriesFromJson(dynamic ids) =>
    ActivismCategories.getCategoriesByIds(
      ids == null ? [] : List<dynamic>.from(ids as List),
    );

List<String> _categoriesToJson(List<ActivismCategory> categories) =>
    categories.map((c) => c.id).toList();

@freezed
class ActivismSourceAuthor with _$ActivismSourceAuthor {
  const factory ActivismSourceAuthor({
    required String name,
    String? url,
  }) = _ActivismSourceAuthor;

  factory ActivismSourceAuthor.fromJson(Map<String, dynamic> json) =>
      _$ActivismSourceAuthorFromJson(json);
}

@freezed
class ActivismSource with _$ActivismSource {
  const factory ActivismSource({
    @Default('') String image,
    @Default('') String title,
    @Default('') String description,
    @JsonKey(name: 'url') @Default('') String link,
    @JsonKey(fromJson: _categoriesFromJson, toJson: _categoriesToJson) @Default([]) List<ActivismCategory> categories,
    @Default([]) List<String> paths,
    ActivismSourceAuthor? by,
    String? group,
    String? type,
    String? language,
    String? region,
    Map<String, dynamic>? socials,
  }) = _ActivismSource;

  factory ActivismSource.fromJson(Map<String, dynamic> json) =>
      _$ActivismSourceFromJson(json);
}
