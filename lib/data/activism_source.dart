import 'package:aktivizam/data/activitsm_categories.dart';

class ActivismSource {
  final String image;

  final String title;

  final String description;

  final String link;

  final List<ActivismCategory> categories;

  ActivismSource({
    required this.image,
    required this.title,
    required this.description,
    required this.link,
    required this.categories,
  });

  static ActivismSource fromJson(Map<String, dynamic> json) {
    final categories = ActivismCategories.getCategoriesByIds(json['categories']);
    return ActivismSource(
      image: json['image'],
      title: json['title'],
      description: json['description'],
      link: json['url'],
      categories: categories,
    );
  }
}
