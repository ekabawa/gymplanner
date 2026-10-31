class WorkoutExercise {
  final String id;
  final String scheduleId;
  final String exerciseId;
  final String exerciseName;
  final String day;
  final int sets;
  final int repetitions;
  final DateTime createdAt;

  WorkoutExercise({
    required this.id,
    required this.scheduleId,
    required this.exerciseId,
    required this.exerciseName,
    required this.day,
    required this.sets,
    required this.repetitions,
    required this.createdAt,
  });

  // Mengubah JSON menjadi objek WorkoutExercise
  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      id: json['id'].toString(),
      scheduleId: json['schedule_id'].toString(),
      exerciseId: json['exercise_id'].toString(),
      exerciseName: json['exercise_name'] ?? '',
      day: json['day'] ?? '',
      sets: json['sets'] ?? 0,
      repetitions: json['repetitions'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Mengubah objek WorkoutExercise menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schedule_id': scheduleId,
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'day': day,
      'sets': sets,
      'repetitions': repetitions,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
