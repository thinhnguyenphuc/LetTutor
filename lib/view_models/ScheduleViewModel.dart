import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/Schedule.dart';

class ScheduleViewModel with ChangeNotifier {
  List<Schedule> schedules = [];
  List<Schedule> nextSchedule = [];

  getScheduleList() async {
    schedules = await ApiServices().fetchSchedule();
    DateTime now = DateTime.now();
    if(schedules.isNotEmpty){
      nextSchedule = [];
      for(Schedule schedule in schedules){
        if(schedule.scheduleDetailInfo.scheduleInfo.date.isAfter(now)){
          nextSchedule.add(schedule);
        }
      }
    }
    notifyListeners();
  }
}