import 'BookingInfoModel.dart';

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
    required this.bookingInfo,
  });

  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String scheduleId;
  final String startPeriod;
  final String endPeriod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BookingInfo? bookingInfo;

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
        bookingInfo: json["BookingInfo"] == null
            ? null
            : BookingInfo.fromJson(json["BookingInfo"]),
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
        "BookingInfo": bookingInfo!.toJson(),
      };
}
