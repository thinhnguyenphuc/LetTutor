import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/BookingInfoModel.dart';
import '../models/TutorModel.dart';

class TutorViewModel with ChangeNotifier {
  List<TutorInfo> tutorList = [];
  Map<String, List<BookingInfo>> schedulesMap = <String, List<BookingInfo>>{};

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
    DateTime now = DateTime.now();
    List<BookingInfo> res = [];
    if (!schedulesMap.containsKey(userId)) {
      List<BookingInfo> bookingList = await ApiServices().fetchBookings(userId);
      for (BookingInfo info in bookingList) {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(info.startTimestamp);
        if(time.isAfter(now)){
          res.add(info);
        }
      }
      schedulesMap[userId] = res;
    }
    notifyListeners();
  }
}
