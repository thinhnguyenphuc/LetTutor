import 'dart:convert';

import 'ScheduleDetailsModel.dart';
import 'TutorModel.dart';

ScheduleInfo scheduleInfoFromJson(String str) =>
    ScheduleInfo.fromJson(json.decode(str));

String scheduleInfoToJson(ScheduleInfo data) => json.encode(data.toJson());

class ScheduleInfo {
  ScheduleInfo({
    required this.date,
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
    required this.tutorInfo,
  });

  final DateTime? date;
  final String id;
  final String tutorId;
  final String startTime;
  final String endTime;
  final int startTimestamp;
  final int endTimestamp;
  final DateTime createdAt;
  final bool isBooked;
  final List<ScheduleDetailInfo> scheduleDetails;
  final TutorInfo? tutorInfo;

  factory ScheduleInfo.fromJson(Map<String, dynamic> json) => ScheduleInfo(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["id"],
        tutorId: json["tutorId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        startTimestamp: json["startTimestamp"],
        endTimestamp: json["endTimestamp"],
        createdAt: DateTime.parse(json["createdAt"]),
        isBooked: json["isBooked"] ?? false,
        scheduleDetails: json["scheduleDetails"] == null
            ? []
            : List<ScheduleDetailInfo>.from(json["scheduleDetails"]
                .map((x) => ScheduleDetailInfo.fromJson(x))),
        tutorInfo: json["tutorInfo"] == null
            ? null
            : TutorInfo.fromJson(json["tutorInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "id": id,
        "tutorId": tutorId,
        "startTime": startTime,
        "endTime": endTime,
        "startTimestamp": startTimestamp,
        "endTimestamp": endTimestamp,
        "createdAt": createdAt.toIso8601String(),
        "isBooked": isBooked,
        "scheduleDetails": List<ScheduleDetailInfo>.from(
            scheduleDetails.map((x) => x.toJson())),
        "tutorInfo": tutorInfo!.toJson(),
      };
}
