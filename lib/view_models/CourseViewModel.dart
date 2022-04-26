import 'package:flutter/cupertino.dart';

import '../data_sources/api_services.dart';
import '../models/Course.dart';

class CourseViewModel with ChangeNotifier {
  List<Course> courseList = [];

  getCourseList() async {
    courseList = await ApiServices().fetchCourse();
    notifyListeners();
  }
}
