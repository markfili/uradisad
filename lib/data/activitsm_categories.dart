class ActivismCategory {
  final String id;
  final String nameEn;
  final String nameHr;
  final String description;

  const ActivismCategory({
    required this.id,
    required this.nameEn,
    required this.nameHr,
    required this.description,
  });

  factory ActivismCategory.fromJson(Map<String, dynamic> json) => ActivismCategory(
        id: json['id'] as String,
        nameEn: json['nameEn'] as String,
        nameHr: json['nameHr'] as String,
        description: json['description'] as String,
      );
}

class ActivismCategories {
  static List<ActivismCategory> categories = [];

  static void setCategories(List<ActivismCategory> loaded) {
    categories = loaded;
  }

  static List<ActivismCategory> getCategoriesByIds(List<dynamic> ids) {
    return categories.where((element) => ids.contains(element.id)).toList();
  }
}
