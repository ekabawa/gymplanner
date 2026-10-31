class WorkoutSchedule {
  final String id;
  final String name;
  final String templateType;
  final String description;
  final DateTime createdAt;

  WorkoutSchedule({
    required this.id,
    required this.name,
    required this.templateType,
    required this.description,
    required this.createdAt,
  });

  // Mengubah JSON menjadi objek WorkoutSchedule
  factory WorkoutSchedule.fromJson(Map<String, dynamic> json) {
    return WorkoutSchedule(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      templateType: json['template_type'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Mengubah objek WorkoutSchedule menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'template_type': templateType,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
