import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/Schedule.dart';

class ScheduleViewModel with ChangeNotifier {
  List<Schedule> schedules = [];

  getScheduleList() async {
    schedules = await ApiServices().fetchSchedule();
    notifyListeners();
  }
}