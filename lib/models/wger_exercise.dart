class WgerExercise {
  final int id;
  final String name;
  final String description;
  final String category;
  final List<String> muscles;
  final List<String> equipment;

  WgerExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.muscles,
    required this.equipment,
  });

  factory WgerExercise.fromJson(Map<String, dynamic> json) {
    final translations = json['translations'] as List<dynamic>? ?? [];

    final translation = translations.firstWhere(
      (item) => item['language'] == 2,
      orElse: () => translations.isNotEmpty
          ? translations.first
          : <String, dynamic>{},
    );

    return WgerExercise(
      id: json['id'] ?? 0,
      name: translation['name'] ?? 'Unknown Exercise',
      description: translation['description'] ?? '',
      category: json['category']?['name'] ?? '',
      muscles: (json['muscles'] as List<dynamic>? ?? [])
          .map((item) => item['name'].toString())
          .toList(),
      equipment: (json['equipment'] as List<dynamic>? ?? [])
          .map((item) => item['name'].toString())
          .toList(),
    );
  }
}
