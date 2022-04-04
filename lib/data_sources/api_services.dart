import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/TutorModel.dart';
import '../models/User.dart';

class ApiServices {
  static String token = "";

  Future<List<Tutor>> fetchTutor() {
    return http.post(Uri.parse("https://sandbox.api.lettutor.com/tutor/search"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        throw FetchDataException(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }

      const JsonDecoder _decoder = JsonDecoder();
      final tutorContainer = _decoder.convert(jsonBody);
      final List tutors = tutorContainer['rows'];
      return tutors.map((contactRaw) => Tutor.fromJson(contactRaw)).toList();
    });
  }

  Future<String> login(String username, String password) {
    var auth = {};
    auth['email'] = username;
    auth['password'] = password;
    return http
        .post(Uri.parse("https://sandbox.api.lettutor.com/auth/login"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(auth))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return "$statusCode "+ response.reasonPhrase.toString();
      } else {
        const JsonDecoder _decoder = JsonDecoder();
        final userContainer = _decoder.convert(jsonBody);
        final User user = User.fromJson(userContainer);
        token = user.tokens.access.token;
        return "SUCCESS";
      }
    });
  }
}

class FetchDataException implements Exception {
  final String _message;

  FetchDataException(this._message);

  @override
  String toString() {
    return "Exception: $_message";
  }
}
