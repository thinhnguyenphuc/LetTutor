import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/ScheduleDetailsModel.dart';
import '../models/ScheduleInfoModel.dart';
import '../models/TutorModel.dart';

class TutorViewModel with ChangeNotifier {
  List<TutorInfo> tutorList = [];
  Map<String, List<ScheduleDetailInfo>> schedulesMap =
      <String, List<ScheduleDetailInfo>>{};

  List<TutorInfo> filteredTutorList(String filter) {
    return tutorList
        .where((tutor) => tutor.specialties.contains(filter))
        .toList();
  }

  getTutorList() async {
    tutorList = await ApiServices().fetchTutor();
    notifyListeners();
  }

  fetchBookings(String userId) async {
    if (!schedulesMap.containsKey(userId)) {
      List<ScheduleDetailInfo> res = [];
      List<ScheduleInfo> scheduleInfoList =
          await ApiServices().fetchBookings(userId);
      for (ScheduleInfo schedulesInfo in scheduleInfoList) {
        for (ScheduleDetailInfo scheduleDetailInfo
            in schedulesInfo.scheduleDetails) {
          res.add(scheduleDetailInfo);
        }
      }
      schedulesMap[userId] = res;
    }
    notifyListeners();
  }
}
