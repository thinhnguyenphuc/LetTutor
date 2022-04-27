import 'dart:convert';

import 'BookingInfo.dart';
import 'ScheduleDetails.dart';
import 'StudentMaterials.dart';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    required this.scheduleDetailId,
    required this.tutorMeetingLink,
    required this.studentMeetingLink,
    required this.studentRequest,
    required this.tutorReview,
    required this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    required this.recordUrl,
    required this.isDeleted,
    required this.scheduleDetailInfo,
    required this.showRecordUrl,
    this.studentMaterials = const [],
    this.bookingInfo = const [],
  });

  final int createdAtTimeStamp;
  final int updatedAtTimeStamp;
  final dynamic id;
  final String userId;
  final String scheduleDetailId;
  final String tutorMeetingLink;
  final String studentMeetingLink;
  late String? studentRequest;
  final String? tutorReview;
  final int? scoreByTutor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? recordUrl;
  final bool isDeleted;
  final ScheduleDetailInfo scheduleDetailInfo;
  final bool showRecordUrl;
  final List<StudentMaterial> studentMaterials;
  final List<BookingInfo> bookingInfo;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        createdAtTimeStamp: json["createdAtTimeStamp"],
        updatedAtTimeStamp: json["updatedAtTimeStamp"],
        id: json["id"],
        userId: json["userId"],
        scheduleDetailId: json["scheduleDetailId"],
        tutorMeetingLink: json["tutorMeetingLink"],
        studentMeetingLink: json["studentMeetingLink"],
        studentRequest: json["studentRequest"],
        tutorReview: json["tutorReview"],
        scoreByTutor: json["scoreByTutor"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        recordUrl: json["recordUrl"],
        isDeleted: json["isDeleted"],
        scheduleDetailInfo:
            ScheduleDetailInfo.fromJson(json["scheduleDetailInfo"]),
        showRecordUrl: json["showRecordUrl"] ?? false,
        studentMaterials: List<StudentMaterial>.from(
            json["studentMaterials"].map((x) => StudentMaterial.fromJson(x))),
        bookingInfo: List<BookingInfo>.from(
          json["studentMaterials"].map((x) => BookingInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdAtTimeStamp": createdAtTimeStamp,
        "updatedAtTimeStamp": updatedAtTimeStamp,
        "id": id,
        "userId": userId,
        "scheduleDetailId": scheduleDetailId,
        "tutorMeetingLink": tutorMeetingLink,
        "studentMeetingLink": studentMeetingLink,
        "studentRequest": studentRequest,
        "tutorReview": tutorReview,
        "scoreByTutor": scoreByTutor,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "recordUrl": recordUrl,
        "isDeleted": isDeleted,
        "scheduleDetailInfo": scheduleDetailInfo.toJson(),
        "showRecordUrl": showRecordUrl,
        "studentMaterials":
            List<StudentMaterial>.from(studentMaterials.map((x) => x.toJson())),
        "bookingInfo":
            List<BookingInfo>.from(bookingInfo.map((x) => x.toJson())),
      };
}

