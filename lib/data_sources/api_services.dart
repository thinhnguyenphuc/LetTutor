import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/CourseModel.dart';

import '../models/EBookModel.dart';
import '../models/PaymentInfoModel.dart';
import '../models/ScheduleInfoModel.dart';
import '../models/ScheduleModel.dart';
import '../models/ServiceMessageModel.dart';
import '../models/TestPreparation.dart';
import '../models/TutorModel.dart';
import '../models/UserModel.dart';

class ApiServices {
  static String baseUrl = "https://sandbox.api.lettutor.com";
  static late Tokens tokens;

  Future<ServiceMessage> fetchTutor() {
    return http
        .get(Uri.parse("$baseUrl/tutor/more?perPage=9&page=1"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens.access.token}'
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

      const JsonDecoder decoder = JsonDecoder();
      final tutorContainer = decoder.convert(jsonBody);
      final List<TutorInfo> tutors = (tutorContainer['tutors']['rows'] as List)
          .map((row) => TutorInfo.fromJson(row))
          .toList();
      final List favoriteJson = tutorContainer['favoriteTutor'];
      final List favorites = favoriteJson
          .map((contactRaw) =>
              contactRaw["secondInfo"] != null ? contactRaw["secondId"] : null)
          .toList();
      final HashMap res = HashMap<String, List>();
      res["tutors"] = tutors;
      res["favoriteTutor"] = favorites;
      return ServiceMessage(statusCode: 200, message: res);
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
        const JsonDecoder decoder = JsonDecoder();
        final userContainer = decoder.convert(jsonBody);
        final ServiceMessage serviceMessage =
            ServiceMessage.fromJson(userContainer);
        return serviceMessage;
      } else {
        const JsonDecoder decoder = JsonDecoder();
        final tokenContainer = decoder.convert(jsonBody);
        tokens = Tokens.fromJson(tokenContainer["tokens"]);
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
        const JsonDecoder decoder = JsonDecoder();
        final messageContainer = decoder.convert(jsonBody);
        final ServiceMessage serviceMessage =
            ServiceMessage.fromJson(messageContainer);
        return serviceMessage;
      }
    });
  }

  Future<List<Schedule>> fetchSchedule() {
    return http.get(
      Uri.parse("$baseUrl/booking/list"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokens.access.token}'
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
        const JsonDecoder decoder = JsonDecoder();
        final dataContainer = decoder.convert(jsonBody);
        final int count = dataContainer['data']['count'];
        return http.get(
          Uri.parse("$baseUrl/booking/list/student?page=1&perPage=$count"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${tokens.access.token}',
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
            const JsonDecoder decoder = JsonDecoder();
            final dataContainer = decoder.convert(jsonBody);
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
    var request = {};
    request['studentRequest'] = requestMessage;
    return http
        .post(Uri.parse("$baseUrl/booking/student-request/$bookedId"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESSFUL");
      }
    });
  }

  Future<List<Course>> fetchCourse() {
    return http.get(Uri.parse("$baseUrl/course"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens.access.token}'
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

      const JsonDecoder decoder = JsonDecoder();
      final courseContainer = decoder.convert(jsonBody);
      final List courses = courseContainer["data"]['rows'];
      return courses.map((contactRaw) => Course.fromJson(contactRaw)).toList();
    });
  }

  Future<List<EBook>> fetchEBook() {
    return http.get(Uri.parse("$baseUrl/e-book"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens.access.token}'
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

      const JsonDecoder decoder = JsonDecoder();
      final eBookContainer = decoder.convert(jsonBody);
      final List eBooks = eBookContainer["data"]['rows'];
      return eBooks.map((contactRaw) => EBook.fromJson(contactRaw)).toList();
    });
  }

  Future<ServiceMessage> cancelBookedClass(String bookedId) {
    var request = {};
    request['scheduleDetailIds'] = [bookedId];
    return http
        .delete(Uri.parse("$baseUrl/booking"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESSFUL");
      }
    });
  }

  Future<List<ScheduleInfo>> fetchBookings(String tutorID) {
    var request = {};
    request['tutorId'] = tutorID;
    return http
        .post(Uri.parse("$baseUrl/schedule"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
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

      const JsonDecoder decoder = JsonDecoder();
      final scheduleContainer = decoder.convert(jsonBody);
      final List scheduleInfoList = scheduleContainer["data"];
      return scheduleInfoList
          .map((contactRaw) => ScheduleInfo.fromJson(contactRaw))
          .toList();
    });
  }

  Future<ServiceMessage> bookClass(String classID, String note) {
    var request = {};
    request['scheduleDetailIds'] = [classID];
    request['note'] = note;
    return http
        .post(Uri.parse("$baseUrl/booking"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      final String jsonBody = response.body;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: statusCode, message: jsonBody);
      }
    });
  }

  Future<ServiceMessage> changePassword(String oldPass, String newPass) {
    var request = {};
    request['password'] = [oldPass];
    request['newPassword'] = [newPass];
    return http
        .post(Uri.parse("$baseUrl/auth/change-password"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESSFUL");
      }
    });
  }

  Future<ServiceMessage> totalLearnedTime() {
    return http.get(Uri.parse("$baseUrl/call/total"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens.access.token}'
    }).then((http.Response response) {
      final int statusCode = response.statusCode;
      final String jsonBody = response.body;
      if (statusCode == 200) {
        const JsonDecoder decoder = JsonDecoder();
        final totalLearnedTime = decoder.convert(jsonBody);
        final int totalTime = totalLearnedTime["total"];
        return ServiceMessage(statusCode: 200, message: totalTime.toString());
      } else {
        return ServiceMessage(statusCode: 200, message: "UNSUCCESSFUL");
      }
    });
  }

  Future<ServiceMessage> fetchPaymentHistory() {
    return http.get(Uri.parse("$baseUrl/payment/history"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens.access.token}'
    }).then((http.Response response) {
      final int statusCode = response.statusCode;
      final String jsonBody = response.body;
      if (statusCode == 200) {
        const JsonDecoder decoder = JsonDecoder();
        final paymentHistory = decoder.convert(jsonBody);
        final List paymentHistoryJson = paymentHistory["data"]["rows"];
        final List<PaymentInfo> paymentHistories = paymentHistoryJson
            .map((contactRaw) => PaymentInfo.fromJson(contactRaw))
            .toList();
        return ServiceMessage(statusCode: 200, message: paymentHistories);
      } else {
        return ServiceMessage(statusCode: 201, message: "UNSUCCESSFUL");
      }
    });
  }

  Future<ServiceMessage> fetchUserInfo() {
    return http.get(Uri.parse("$baseUrl/user/info"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens.access.token}'
    }).then((http.Response response) {
      final int statusCode = response.statusCode;
      final String jsonBody = response.body;
      if (statusCode == 200) {
        const JsonDecoder decoder = JsonDecoder();
        final userContainer = decoder.convert(jsonBody);
        final User userInfo = User.fromJson(userContainer);
        return ServiceMessage(statusCode: 200, message: userInfo);
      } else {
        return ServiceMessage(statusCode: 201, message: "UNSUCCESSFUL");
      }
    });
  }

  Future<ServiceMessage> updateFavorite(String userId) {
    var request = {};
    request['tutorId'] = userId;
    return http
        .post(Uri.parse("$baseUrl/user/manageFavoriteTutor"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      final String jsonBody = response.body;
      return ServiceMessage(statusCode: statusCode, message: jsonBody);
    });
  }

  Future<ServiceMessage> updateUserInfo(
      String name,
      String country,
      String phone,
      String birthday,
      String level,
      List<LearnTopic> learnTopics,
      List<TestPreparation> testPreparations) {
    var request = {};
    request['name'] = name;
    request['country'] = country;
    request['phone'] = phone;
    request['birthday'] = birthday;
    request['level'] = level;

    List<int> learnTopicsID = [];
    for(LearnTopic learnTopic in learnTopics){
      learnTopicsID.add(learnTopic.id);
    }
    List<int> testPreparationsID = [];
    for(TestPreparation testPreparation in testPreparations){
      testPreparationsID.add(testPreparation.id);
    }

    request['learnTopics'] = learnTopicsID;
    request['testPreparations'] = testPreparationsID;

    return http
        .put(Uri.parse("$baseUrl/user/info"),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${tokens.access.token}'
            },
            body: jsonEncode(request))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return ServiceMessage(statusCode: 200, message: "SUCCESS");
      } else {
        return ServiceMessage(statusCode: 201, message: "UNSUCCESSFUL");
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
