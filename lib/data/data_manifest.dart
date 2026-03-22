class DataManifest {
  final DateTime generatedAt;

  const DataManifest({required this.generatedAt});

  factory DataManifest.fromJson(Map<String, dynamic> json) => DataManifest(
        generatedAt: DateTime.parse(json['generated_at'] as String),
      );

  Map<String, dynamic> toJson() => {'generated_at': generatedAt.toIso8601String()};
}
