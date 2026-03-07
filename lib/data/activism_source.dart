import 'package:aktivizam/data/activitsm_categories.dart';

class ActivismSourceAuthor {
  final String name;
  final String? url;

  const ActivismSourceAuthor({required this.name, this.url});

  static ActivismSourceAuthor? fromJson(dynamic json) {
    if (json == null) return null;
    return ActivismSourceAuthor(
      name: json['name'] ?? '',
      url: json['url'] as String?,
    );
  }
}

class ActivismSource {
  final String image;
  final String title;
  final String description;
  final String link;
  final List<ActivismCategory> categories;
  final ActivismSourceAuthor? by;
  final String? group;
  final String? type;
  final String? language;
  final String? region;
  final Map<String, dynamic>? socials;

  ActivismSource({
    required this.image,
    required this.title,
    required this.description,
    required this.link,
    required this.categories,
    this.by,
    this.group,
    this.type,
    this.language,
    this.region,
    this.socials,
  });

  static ActivismSource fromJson(Map<String, dynamic> json) {
    final categories = ActivismCategories.getCategoriesByIds(json['categories'] ?? []);
    return ActivismSource(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['url'] ?? '',
      categories: categories,
      by: ActivismSourceAuthor.fromJson(json['by']),
      group: json['group'] as String?,
      type: json['type'] as String?,
      language: json['language'] as String?,
      region: json['region'] as String?,
      socials: json['socials'] as Map<String, dynamic>?,
    );
  }
}
