// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activism_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivismSourceAuthorImpl _$$ActivismSourceAuthorImplFromJson(
        Map<String, dynamic> json) =>
    _$ActivismSourceAuthorImpl(
      name: json['name'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ActivismSourceAuthorImplToJson(
        _$ActivismSourceAuthorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_$ActivismSourceImpl _$$ActivismSourceImplFromJson(Map<String, dynamic> json) =>
    _$ActivismSourceImpl(
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      link: json['url'] as String? ?? '',
      categories: json['categories'] == null
          ? const []
          : _categoriesFromJson(json['categories']),
      by: json['by'] == null
          ? null
          : ActivismSourceAuthor.fromJson(json['by'] as Map<String, dynamic>),
      group: json['group'] as String?,
      type: json['type'] as String?,
      language: json['language'] as String?,
      region: json['region'] as String?,
      socials: json['socials'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ActivismSourceImplToJson(
        _$ActivismSourceImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'url': instance.link,
      'categories': _categoriesToJson(instance.categories),
      'by': instance.by,
      'group': instance.group,
      'type': instance.type,
      'language': instance.language,
      'region': instance.region,
      'socials': instance.socials,
    };
