import 'package:flutter/material.dart';
import 'package:project/data_sources/api_services.dart';

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
}