import 'dart:collection';

import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/ScheduleDetailsModel.dart';
import '../models/ScheduleInfoModel.dart';
import '../models/ServiceMessageModel.dart';
import '../models/TutorModel.dart';
import '../resources/CountryList.dart';

class TutorViewModel with ChangeNotifier {
  List<TutorInfo> tutorList = [];
  List<String> favorites = [];
  Map<String, List<ScheduleDetailInfo>> schedulesMap =
      <String, List<ScheduleDetailInfo>>{};

  List<TutorInfo> filteredTutorList(
      String tutorName, String skill, String country) {
    return _filterByCountry(
        _filterByName(_filterBySkill(tutorList, skill), tutorName), country);
  }

  List<TutorInfo> _filterByCountry(List<TutorInfo> inputList, String country) {
    if (country == "ALL") return inputList;
    return inputList
        .where((tutor) =>
            CountrySingleton().countryHashMap[tutor.country] != null &&
            CountrySingleton().countryHashMap[tutor.country] == country)
        .toList();
  }

  List<TutorInfo> _filterBySkill(List<TutorInfo> inputList, String skill) {
    if (skill == "all") return inputList;
    return inputList
        .where((tutor) =>
            tutor.specialties.toLowerCase().contains(skill.toLowerCase()))
        .toList();
  }

  List<TutorInfo> _filterByName(List<TutorInfo> inputList, String tutorName) {
    if (tutorName.isEmpty) return inputList;
    return inputList
        .where((tutor) =>
            tutor.name.toLowerCase().contains(tutorName.toLowerCase()))
        .toList();
  }

  getTutorList() async {
    ServiceMessage response = await ApiServices().fetchTutor();
    tutorList = (response.message as HashMap<String, List>)["tutors"] as List<TutorInfo>;
    favorites = (response.message as HashMap<String, List>)["favoriteTutor"]!.cast<String>();
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

  updateFavorite(String userId) async {
    await ApiServices().updateFavorite(userId).then((value){
      if(value.statusCode == 200 ){
        getTutorList();
      }
    });
  }
}
