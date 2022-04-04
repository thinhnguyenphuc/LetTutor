import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';

class LoginViewModel with ChangeNotifier {
  Future<String> login(String username, String password) async {
    return await ApiServices().login(username, password);
  }
}
