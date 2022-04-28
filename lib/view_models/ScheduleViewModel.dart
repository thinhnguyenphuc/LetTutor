import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/ScheduleModel.dart';
import '../models/ServiceMessageModel.dart';

class ScheduleViewModel with ChangeNotifier {
  List<Schedule> schedules = [];
  List<Schedule> nextSchedule = [];
  List<Schedule> historySchedule = [];
  bool isLoaded = false;
  bool _isNotCalculated = true;
  bool _isNotFetchedNextSchedule = true;
  bool _isNotFetchedHistorySchedule = true;
  String totalLearnedTimeString = "";

  calTotalLearnedTime() async {
    DateTime now = DateTime.now();
    if (_isNotCalculated) {
      int minutes = 0;
      for (Schedule schedule in schedules) {
        var from = DateTime.fromMicrosecondsSinceEpoch(
            schedule.scheduleDetailInfo!.startPeriodTimestamp * 1000);
        var to = DateTime.fromMicrosecondsSinceEpoch(
            schedule.scheduleDetailInfo!.endPeriodTimestamp * 1000);
        if (schedule.scheduleDetailInfo!.bookingInfo!.date!.isBefore(now)) {
          minutes += to.difference(from).inMinutes;
        }
      }
      int hours = (minutes / 60).round();
      minutes = minutes - hours * 60;
      totalLearnedTimeString = "$hours hours and $minutes minutes";
      _isNotCalculated = false;
    }
  }

  _fetchNextSchedule() async {
    DateTime now = DateTime.now();
    if (schedules.isNotEmpty && _isNotFetchedNextSchedule) {
      for (Schedule schedule in schedules) {
        var date = DateTime.fromMicrosecondsSinceEpoch(
            schedule.scheduleDetailInfo!.bookingInfo!.startTimestamp * 1000);
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
            schedule.scheduleDetailInfo!.bookingInfo!.startTimestamp * 1000);
        if (date.isBefore(now)) {
          historySchedule.add(schedule);
        }
      }
      _isNotFetchedHistorySchedule = false;
    }
  }

  fetchSchedule() async {
    schedules = await ApiServices().fetchSchedule();
    isLoaded = true;
    _fetchNextSchedule();
    calTotalLearnedTime();
    notifyListeners();
    _fetchHistorySchedule();
  }

  Future<ServiceMessage> updateStudentRequest(bookedId, request) async {
    ServiceMessage updateStudentRequestStatus =
        await ApiServices().updateStudentRequest(bookedId, request);
    return updateStudentRequestStatus;
  }

  fetchScheduleAgain() async {
    schedules = await ApiServices().fetchSchedule();
    nextSchedule.clear();
    _isNotFetchedNextSchedule = true;
    _isNotFetchedNextSchedule = true;
    _fetchNextSchedule();
    calTotalLearnedTime();
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
}
