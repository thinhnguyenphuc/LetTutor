import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/ScheduleModel.dart';
import '../models/ServiceMessageModel.dart';

class ScheduleViewModel with ChangeNotifier {
  List<Schedule> schedules = [];
  List<Schedule> nextSchedule = [];
  List<Schedule> historySchedule = [];
  bool isLoaded = false;
  bool _isNotFetchedNextSchedule = true;
  bool _isNotFetchedHistorySchedule = true;
  String totalLearnedTimeString = "";

  _fetchNextSchedule() async {
    DateTime now = DateTime.now();
    if (schedules.isNotEmpty && _isNotFetchedNextSchedule) {
      for (Schedule schedule in schedules) {
        var date = DateTime.fromMicrosecondsSinceEpoch(
            schedule.scheduleDetailInfo!.startPeriodTimestamp * 1000);
        if (date.isAfter(now)) {
          nextSchedule.add(schedule);
        }
      }
      _isNotFetchedNextSchedule = false;
    }
  }

  _fetchHistorySchedule() async {
    DateTime now = DateTime.now();
    if (schedules.isNotEmpty && _isNotFetchedHistorySchedule) {
      for (Schedule schedule in schedules) {
        var date = DateTime.fromMicrosecondsSinceEpoch(
            schedule.scheduleDetailInfo!.startPeriodTimestamp* 1000);
        if (date.isBefore(now)) {
          historySchedule.add(schedule);
        }
      }
      _isNotFetchedHistorySchedule = false;
    }
  }

  fetchSchedule() async {
    getTotalLearner();
    schedules = await ApiServices().fetchSchedule();
    isLoaded = true;
    _fetchNextSchedule();
    notifyListeners();
    _fetchHistorySchedule();
  }

  Future<ServiceMessage> updateStudentRequest(bookedId, request) async {
    ServiceMessage updateStudentRequestStatus =
        await ApiServices().updateStudentRequest(bookedId, request);
    return updateStudentRequestStatus;
  }

  fetchScheduleAgain() async {
    isLoaded = false;
    notifyListeners();
    getTotalLearner();
    schedules = await ApiServices().fetchSchedule();
    nextSchedule.clear();
    _isNotFetchedNextSchedule = true;
    _isNotFetchedNextSchedule = true;
    _fetchNextSchedule();
    isLoaded = true;
    notifyListeners();
    _fetchHistorySchedule();
  }

  Future<ServiceMessage> cancelBookedClass(String scheduleDetailId) async {
    ServiceMessage cancelBookedClassStatus =
        await ApiServices().cancelBookedClass(scheduleDetailId);
    return cancelBookedClassStatus;
  }

  Future<ServiceMessage> bookClass(String bookedId, String note) async {
    ServiceMessage bookClassStatus =
        await ApiServices().bookClass(bookedId, note);
    return bookClassStatus;
  }

  getTotalLearner() async {
    ServiceMessage totalLearnedTimeStatus =
    await ApiServices().totalLearnedTime();
    int minutes = int.parse(totalLearnedTimeStatus.message);
    int hours = minutes ~/ 60;
    minutes = minutes - hours * 60;
    totalLearnedTimeString = "$hours hours and $minutes minutes";
    notifyListeners();
  }
}
