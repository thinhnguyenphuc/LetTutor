import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/TutorModel.dart';

class TutorViewModel with ChangeNotifier {
  List<TutorInfo> tutorList = [];
  List<TutorInfo> filteredTutorList(String filter) {
    List<TutorInfo> res = [];
    for (TutorInfo item in tutorList){
      if(item.specialties.contains(filter)){
        res.add(item);
      }
    }
    return res;
  }

  getTutorList() async {
    tutorList = await ApiServices().fetchTutor();
    notifyListeners();
  }
}
