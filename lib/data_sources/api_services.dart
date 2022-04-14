import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/Schedule.dart';
import '../models/ServiceMessageModel.dart';
import '../models/TutorModel.dart';
import '../models/User.dart';

class ApiServices {
  static String token = "";
  static String baseUrl = "https://sandbox.api.lettutor.com";

  Future<List<TutorInfo>> fetchTutor() {
    return http.post(Uri.parse("$baseUrl/tutor/search"),
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
      return tutors.map((contactRaw) => TutorInfo.fromJson(contactRaw)).toList();
    });
  }

  Future<ServiceMessage> login(String username, String password) {
    var auth = {};
    auth['email'] = username;
    auth['password'] = password;
    return http
        .post(Uri.parse("$baseUrl/auth/login"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(auth))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        const JsonDecoder _decoder = JsonDecoder();
        final userContainer = _decoder.convert(jsonBody);
        final ServiceMessage serviceMessage =
        ServiceMessage.fromJson(userContainer);

        return serviceMessage;
      }
      else {
        const JsonDecoder _decoder = JsonDecoder();
        final userContainer = _decoder.convert(jsonBody);
        final User user = User.fromJson(userContainer);
        token = user.tokens.access.token;
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      }
    });
  }

  Future<ServiceMessage> register(String email, String password) {
    var auth = {};
    auth['email'] = email;
    auth['password'] = password;
    return http
        .post(Uri.parse("$baseUrl/auth/register"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(auth))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode == 201) {
        return ServiceMessage(statusCode: 201, message: "CREATED");
      } else {
        const JsonDecoder _decoder = JsonDecoder();
        final messageContainer = _decoder.convert(jsonBody);
        final ServiceMessage serviceMessage =
        ServiceMessage.fromJson(messageContainer);
        return serviceMessage;
      }
    });
  }

  Future<List<Schedule>> fetchSchedule() {
    return http
        .get(Uri.parse("$baseUrl/booking/list"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        throw FetchDataException(
            "StatusCode:$statusCode, Error:${response.body}");
      } else {
        const JsonDecoder _decoder = JsonDecoder();
        final dataContainer = _decoder.convert(jsonBody);
        final int count = dataContainer['data']['count'];
        return http
            .get(Uri.parse("$baseUrl/booking/list/student?page=1&perPage=$count"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
            .then((http.Response response) {
          final String jsonBody = response.body;
          final int statusCode = response.statusCode;

          if (statusCode != 200) {
            if (kDebugMode) {
              print(response.reasonPhrase);
            }
            throw FetchDataException(
                "StatusCode:$statusCode, Error:${response.body}");
          } else {
            const JsonDecoder _decoder = JsonDecoder();
            final dataContainer = _decoder.convert(jsonBody);
            final List schedules = dataContainer['data']['rows'];
            return schedules.map((contactRaw) => Schedule.fromJson(contactRaw)).toList();
          }
        });
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
