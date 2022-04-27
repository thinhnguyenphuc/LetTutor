import 'TutorModel.dart';

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

  factory ScheduleDetailInfo.fromJson(Map<String, dynamic> json) =>
      ScheduleDetailInfo(
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
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
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
