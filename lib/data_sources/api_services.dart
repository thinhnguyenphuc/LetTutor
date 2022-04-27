import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/Course.dart';

import '../models/EBookModel.dart';
import '../models/Schedule.dart';
import '../models/ServiceMessageModel.dart';
import '../models/TutorModel.dart';
import '../models/User.dart';
import '../resources/UserInfoSingleton.dart';

class ApiServices {
  static String baseUrl = "https://sandbox.api.lettutor.com";

  Future<List<TutorInfo>> fetchTutor() {
    String token = UserInfoLazyInitializedSingleton().getToken();
    return http.post(Uri.parse("$baseUrl/tutor/search"), headers: {
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
      return tutors
          .map((contactRaw) => TutorInfo.fromJson(contactRaw))
          .toList();
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
      } else {
        const JsonDecoder _decoder = JsonDecoder();
        final userContainer = _decoder.convert(jsonBody);
        final User user = User.fromJson(userContainer);
        UserInfoLazyInitializedSingleton().setUserInfo(user);
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

      if (statusCode == 201) {
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
    String token = UserInfoLazyInitializedSingleton().getToken();
    return http.get(
      Uri.parse("$baseUrl/booking/list"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    ).then((http.Response response) {
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
        return http.get(
          Uri.parse("$baseUrl/booking/list/student?page=1&perPage=$count"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).then((http.Response response) {
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
            return schedules
                .map((contactRaw) => Schedule.fromJson(contactRaw))
                .toList();
          }
        });
      }
    });
  }

  Future<ServiceMessage> updateStudentRequest(
      String bookedId, String requestMessage) {
    String token = UserInfoLazyInitializedSingleton().getToken();
    var request = {};
    request['studentRequest'] = requestMessage;
    return http
        .post(Uri.parse("$baseUrl/booking/student-request/$bookedId"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESS");
      }
    });
  }

  Future<List<Course>> fetchCourse() {
    String token = UserInfoLazyInitializedSingleton().getToken();
    return http.get(Uri.parse("$baseUrl/course"), headers: {
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
      final courseContainer = _decoder.convert(jsonBody);
      final List courses = courseContainer["data"]['rows'];
      return courses.map((contactRaw) => Course.fromJson(contactRaw)).toList();
    });
  }

  Future<List<EBook>> fetchEBook() {
    String token = UserInfoLazyInitializedSingleton().getToken();
    return http.get(Uri.parse("$baseUrl/e-book"), headers: {
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
      final eBookContainer = _decoder.convert(jsonBody);
      final List eBooks = eBookContainer["data"]['rows'];
      return eBooks.map((contactRaw) => EBook.fromJson(contactRaw)).toList();
    });
  }

  Future<ServiceMessage> cancelBookedClass(String bookedId) {
    String token = UserInfoLazyInitializedSingleton().getToken();
    var request = {};
    request['scheduleDetailIds'] = [bookedId];
    return http
        .delete(Uri.parse("$baseUrl/booking"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESS");
      }
    });
  }

  Future<List<Schedule>> fetchBookings(String tutorID){
    String token = UserInfoLazyInitializedSingleton().getToken();
    var request = {};
    request['tutorId'] = [tutorID];
    return http
        .post(Uri.parse("$baseUrl/schedule"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      final String jsonBody = response.body;
      if (statusCode != 200) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        throw FetchDataException(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }

      const JsonDecoder _decoder = JsonDecoder();
      final scheduleContainer = _decoder.convert(jsonBody);
      final List schedules = scheduleContainer["data"];
      return schedules.map((contactRaw) => Schedule.fromJson(contactRaw)).toList();
    });
  }

  Future<ServiceMessage> bookClass(String classID, String note){
    String token = UserInfoLazyInitializedSingleton().getToken();
    var request = {};
    request['scheduleDetailIds'] = [classID];
    request['note'] = [note];
    return http
        .post(Uri.parse("$baseUrl/booking"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESS");
      }
    });
  }

  Future<ServiceMessage> changePassword(String oldPass, String newPass){
    String token = UserInfoLazyInitializedSingleton().getToken();
    var request = {};
    request['password'] = [oldPass];
    request['newPassword'] = [newPass];
    return http
        .post(Uri.parse("$baseUrl/auth/change-password"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESS");
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
