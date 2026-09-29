// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activism_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivismSourceAuthor _$ActivismSourceAuthorFromJson(
        Map<String, dynamic> json) =>
    _ActivismSourceAuthor(
      name: json['name'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ActivismSourceAuthorToJson(
        _ActivismSourceAuthor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_ActivismSource _$ActivismSourceFromJson(Map<String, dynamic> json) =>
    _ActivismSource(
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      link: json['url'] as String? ?? '',
      categories: json['categories'] == null
          ? const []
          : _categoriesFromJson(json['categories']),
      paths:
          (json['paths'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      by: json['by'] == null
          ? null
          : ActivismSourceAuthor.fromJson(json['by'] as Map<String, dynamic>),
      group: json['group'] as String?,
      type: json['type'] as String?,
      language: json['language'] as String?,
      region: json['region'] as String?,
      socials: json['socials'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActivismSourceToJson(_ActivismSource instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'url': instance.link,
      'categories': _categoriesToJson(instance.categories),
      'paths': instance.paths,
      'by': instance.by,
      'group': instance.group,
      'type': instance.type,
      'language': instance.language,
      'region': instance.region,
      'socials': instance.socials,
    };
