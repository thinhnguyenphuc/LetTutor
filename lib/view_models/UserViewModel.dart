import 'package:flutter/material.dart';
import 'package:project/data_sources/api_services.dart';

import '../models/TestPreparation.dart';
import '../models/UserModel.dart';

class UserViewModel with ChangeNotifier {
  bool isFetching = false;
  UserClass? userInfo;

  fetchUserInfo() async {
    await ApiServices().fetchUserInfo().then((value) {
      User user = value.message;
      userInfo = user.user;
      isFetching = true;
      notifyListeners();
    });
  }

  updateInfo(String name, String country,
      String phone, String birthday, String level, List<LearnTopic> topic,
      List<TestPreparation> testPreparations) async {
    await ApiServices().updateUserInfo(
        name,
        country,
        phone,
        birthday,
        level,
        topic,
        testPreparations).then((value) {
          if(value.statusCode == 200){
            fetchUserInfo();
          }
    });
  }
}
