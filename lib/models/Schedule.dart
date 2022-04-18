import 'dart:convert';

import 'StudentMaterials.dart';
import 'TutorModel.dart';

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
  });

  final int createdAtTimeStamp;
  final int updatedAtTimeStamp;
  final String id;
  final String userId;
  final String scheduleDetailId;
  final String tutorMeetingLink;
  final String studentMeetingLink;
  final String? studentRequest;
  final String? tutorReview;
  final int? scoreByTutor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? recordUrl;
  final bool isDeleted;
  final ScheduleDetailInfo scheduleDetailInfo;
  final bool showRecordUrl;
  final List<StudentMaterial> studentMaterials;

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
    scheduleDetailInfo: ScheduleDetailInfo.fromJson(json["scheduleDetailInfo"]),
    showRecordUrl: json["showRecordUrl"]?? false,
    studentMaterials: List<StudentMaterial>.from(json["studentMaterials"].map((x) => StudentMaterial.fromJson(x))),
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
    "studentMaterials": List<StudentMaterial>.from(studentMaterials.map((x) => x.toJson())),
  };
}

class ScheduleDetailInfo {
  ScheduleDetailInfo({
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.id,
    required this.scheduleId,
    required this.startPeriod,
    required this.endPeriod,
    required this.createdAt,
    required this.updatedAt,
    required this.scheduleInfo,
  });

  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String scheduleId;
  final String startPeriod;
  final String endPeriod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ScheduleInfo scheduleInfo;

  factory ScheduleDetailInfo.fromJson(Map<String, dynamic> json) => ScheduleDetailInfo(
    startPeriodTimestamp: json["startPeriodTimestamp"],
    endPeriodTimestamp: json["endPeriodTimestamp"],
    id: json["id"],
    scheduleId: json["scheduleId"],
    startPeriod: json["startPeriod"],
    endPeriod: json["endPeriod"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    scheduleInfo: ScheduleInfo.fromJson(json["scheduleInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "startPeriodTimestamp": startPeriodTimestamp,
    "endPeriodTimestamp": endPeriodTimestamp,
    "id": id,
    "scheduleId": scheduleId,
    "startPeriod": startPeriod,
    "endPeriod": endPeriod,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "scheduleInfo": scheduleInfo.toJson(),
  };
}

class ScheduleInfo {
  ScheduleInfo({
    required this.date,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.tutorInfo,
  });

  final DateTime date;
  final int startTimestamp;
  final int endTimestamp;
  final String id;
  final String tutorId;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TutorInfo tutorInfo;

  factory ScheduleInfo.fromJson(Map<String, dynamic> json) => ScheduleInfo(
    date: DateTime.parse(json["date"]),
    startTimestamp: json["startTimestamp"],
    endTimestamp: json["endTimestamp"],
    id: json["id"],
    tutorId: json["tutorId"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    tutorInfo: TutorInfo.fromJson(json["tutorInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "startTimestamp": startTimestamp,
    "endTimestamp": endTimestamp,
    "id": id,
    "tutorId": tutorId,
    "startTime": startTime,
    "endTime": endTime,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "tutorInfo": tutorInfo.toJson(),
  };
}
