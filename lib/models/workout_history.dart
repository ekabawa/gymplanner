class WorkoutHistory {
  final String id;
  final String scheduleId;
  final String exerciseName;
  final String status;
  final DateTime completedAt;
  final String notes;

  WorkoutHistory({
    required this.id,
    required this.scheduleId,
    required this.exerciseName,
    required this.status,
    required this.completedAt,
    required this.notes,
  });

  // Mengubah JSON menjadi objek WorkoutHistory
  factory WorkoutHistory.fromJson(Map<String, dynamic> json) {
    return WorkoutHistory(
      id: json['id'].toString(),
      scheduleId: json['schedule_id'].toString(),
      exerciseName: json['exercise_name'] ?? '',
      status: json['status'] ?? '',
      completedAt: DateTime.parse(json['completed_at']),
      notes: json['notes'] ?? '',
    );
  }

  // Mengubah objek WorkoutHistory menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schedule_id': scheduleId,
      'exercise_name': exerciseName,
      'status': status,
      'completed_at': completedAt.toIso8601String(),
      'notes': notes,
    };
  }
}
