import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/ServiceMessageModel.dart';

class LoginViewModel with ChangeNotifier {
  Future<ServiceMessage> login(String username, String password) async {
    return await ApiServices().login(username, password);
  }
}
