import '../data_sources/api_services.dart';
import '../models/Course.dart';

class CourseViewModel {
  final List<Course> courseList = [];


  getCourseList() async {
    courseList = await ApiServices().getCourseList
  }

}