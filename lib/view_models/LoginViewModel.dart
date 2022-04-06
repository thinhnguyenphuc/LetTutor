import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';

class LoginViewModel with ChangeNotifier {
<<<<<<< Updated upstream
  Future<String> login(String username, String password) async {
=======
  Future<bool> login(String username, String password) async {
>>>>>>> Stashed changes
    return await ApiServices().login(username, password);
  }
}
