import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/TutorModel.dart';

class TutorViewModel with ChangeNotifier {
  List<TutorInfo> tutorList = [];

  getTutorList() async {
    tutorList = await ApiServices().fetchTutor();
    notifyListeners();
  }
}
