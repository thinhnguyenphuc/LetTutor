import 'dart:convert';

import 'ScheduleDetailsModel.dart';
import 'UserModel.dart';

BookingInfo bookingInfoFromJson(String str) => BookingInfo.fromJson(json.decode(str));

String bookingInfoToJson(BookingInfo data) => json.encode(data.toJson());

class BookingInfo {
  BookingInfo({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    required this.scheduleDetailId,
    required this.scheduleDetailInfo,
    required this.tutorMeetingLink,
    required this.studentMeetingLink,
    required this.studentRequest,
    required this.tutorReview,
    required this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    required this.recordUrl,
    required this.isDeleted,
    required this.userInfo,
  });

  final int createdAtTimeStamp;
  final int updatedAtTimeStamp;
  final String id;
  final String userId;
  final String scheduleDetailId;
  final ScheduleDetailInfo scheduleDetailInfo;
  final String tutorMeetingLink;
  final String studentMeetingLink;
  final dynamic studentRequest;
  final dynamic tutorReview;
  final dynamic scoreByTutor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic recordUrl;
  final bool isDeleted;
  final UserClass userInfo;

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
    createdAtTimeStamp: json["createdAtTimeStamp"],
    updatedAtTimeStamp: json["updatedAtTimeStamp"],
    id: json["id"],
    userId: json["userId"],
    scheduleDetailId: json["scheduleDetailId"],
    scheduleDetailInfo: ScheduleDetailInfo.fromJson(json["scheduleDetailInfo"]),
    tutorMeetingLink: json["tutorMeetingLink"],
    studentMeetingLink: json["studentMeetingLink"],
    studentRequest: json["studentRequest"],
    tutorReview: json["tutorReview"],
    scoreByTutor: json["scoreByTutor"],
    createdAt:json["createdAt"] == null ? DateTime.parse("2000-01-01") : DateTime.parse(json["createdAt"]),
    updatedAt:json["updatedAt"] == null ? DateTime.parse("2000-01-01") : DateTime.parse(json["updatedAt"]),
    recordUrl: json["recordUrl"],
    isDeleted: json["isDeleted"],
    userInfo: UserClass.fromJson(json["userInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "createdAtTimeStamp": createdAtTimeStamp,
    "updatedAtTimeStamp": updatedAtTimeStamp,
    "id": id,
    "userId": userId,
    "scheduleDetailId": scheduleDetailId,
    "scheduleDetailInfo": scheduleDetailInfo.toJson(),
    "tutorMeetingLink": tutorMeetingLink,
    "studentMeetingLink": studentMeetingLink,
    "studentRequest": studentRequest,
    "tutorReview": tutorReview,
    "scoreByTutor": scoreByTutor,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "recordUrl": recordUrl,
    "isDeleted": isDeleted,
  };
}
