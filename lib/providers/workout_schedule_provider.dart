import 'package:flutter/foundation.dart';

import '../models/workout_schedule.dart';
import '../repositories/workout_schedule_repository.dart';

class WorkoutScheduleProvider extends ChangeNotifier {
  final WorkoutScheduleRepository _repository =
      WorkoutScheduleRepository();

  List<WorkoutSchedule> _schedules = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<WorkoutSchedule> get schedules => _schedules;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSchedules() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _schedules = await _repository.getSchedules();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
