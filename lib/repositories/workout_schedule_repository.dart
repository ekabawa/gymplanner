import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/workout_schedule.dart';

class WorkoutScheduleRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<WorkoutSchedule>> getSchedules() async {
    final response = await _client
        .from('workout_schedules')
        .select()
        .order('created_at', ascending: false);

    return response
        .map((item) => WorkoutSchedule.fromJson(item))
        .toList();
  }
}
