import 'package:flutter/material.dart';

import '../data_sources/api_services.dart';
import '../models/ServiceMessageModel.dart';

class RegisterViewModel with ChangeNotifier {
  Future<ServiceMessage> register(String username, String password) async {
    return await ApiServices().register(username, password);
  }
}
