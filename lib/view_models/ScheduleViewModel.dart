import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/Schedule.dart';

class ScheduleViewModel with ChangeNotifier {
  List<Schedule> schedules = [];
  List<Schedule> nextSchedule = [];
  String totalLearnedTime = "";

  getScheduleList() async {
    int totalLearnTime = 0;
    schedules = await ApiServices().fetchSchedule();
    DateTime now = DateTime.now();
    if(schedules.isNotEmpty){
      nextSchedule = [];
      for(Schedule schedule in schedules){
        if(schedule.scheduleDetailInfo.scheduleInfo.date.isAfter(now)){
          nextSchedule.add(schedule);
        } else {
          totalLearnTime += schedule.scheduleDetailInfo.endPeriodTimestamp - schedule.scheduleDetailInfo.startPeriodTimestamp;
        }
      }
    }
    totalLearnedTime = _calTotalLearnedTime(totalLearnTime);
    notifyListeners();
  }

  String _calTotalLearnedTime(int totalLearnedTime){
    int hours = (totalLearnedTime/1000)~/3600;
    double minutes = (totalLearnedTime/1000)%3600/60;
    return "$hours hours $minutes minutes";
  }
}