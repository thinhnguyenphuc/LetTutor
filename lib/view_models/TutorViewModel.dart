import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/BookingInfoModel.dart';
import '../models/ScheduleDetailsModel.dart';
import '../models/ScheduleInfoModel.dart';
import '../models/TutorModel.dart';

class TutorViewModel with ChangeNotifier {
  List<TutorInfo> tutorList = [];
  Map<String, List<ScheduleDetailInfo>> schedulesMap = <String, List<ScheduleDetailInfo>>{};

  List<TutorInfo> filteredTutorList(String filter) {
    List<TutorInfo> res = [];
    for (TutorInfo item in tutorList) {
      if (item.specialties.contains(filter)) {
        res.add(item);
      }
    }
    return res;
  }

  getTutorList() async {
    tutorList = await ApiServices().fetchTutor();
    notifyListeners();
  }

  fetchBookings(String userId) async {
    List<ScheduleDetailInfo> res = [];
    if (!schedulesMap.containsKey(userId)) {
      List<ScheduleInfo> scheduleInfoList = await ApiServices().fetchBookings(userId);
      for (ScheduleInfo schedulesInfo in scheduleInfoList) {
        if(schedulesInfo.isBooked){
          for(ScheduleDetailInfo scheduleDetailInfo in schedulesInfo.scheduleDetails){
            res.add(scheduleDetailInfo);
          }
        }
      }
      schedulesMap[userId] = res;
    }
    notifyListeners();
  }
}
