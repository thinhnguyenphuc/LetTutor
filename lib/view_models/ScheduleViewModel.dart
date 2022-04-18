import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/Schedule.dart';
import '../models/ServiceMessageModel.dart';

class ScheduleViewModel with ChangeNotifier {
  List<Schedule> schedules = [];
  List<Schedule> nextSchedule = [];
  List<Schedule> historySchedule = [];
  bool isLoaded = false;
  String totalLearnedTime = "";
  ServiceMessage updateStudentRequestStatus = ServiceMessage(statusCode: 0, message: "");

  getScheduleList() async {
    int totalLearnTime = 0;
    schedules = await ApiServices().fetchSchedule();
    DateTime now = DateTime.now();
    if (schedules.isNotEmpty) {
      nextSchedule = [];
      for (Schedule schedule in schedules) {
        if (schedule.scheduleDetailInfo.scheduleInfo.date.isAfter(now)) {
          nextSchedule.add(schedule);
        } else {
          historySchedule.add(schedule);
          totalLearnTime += schedule.scheduleDetailInfo.endPeriodTimestamp -
              schedule.scheduleDetailInfo.startPeriodTimestamp;
        }
      }
    }
    totalLearnedTime = _calTotalLearnedTime(totalLearnTime);
    isLoaded = true;
    notifyListeners();
  }

  updateStudentRequest(bookedId, request) async{
    updateStudentRequestStatus = await ApiServices().updateStudentRequest(bookedId, request);
    notifyListeners();
  }

  String _calTotalLearnedTime(int totalLearnedTime) {
    int hours = (totalLearnedTime / 1000) ~/ 3600;
    double minutes = (totalLearnedTime / 1000) % 3600 / 60;
    return "$hours hours $minutes minutes";
  }
}
