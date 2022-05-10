import 'BookingInfoModel.dart';
import 'ScheduleInfoModel.dart';
import 'TutorModel.dart';

class ScheduleDetailInfo {
  ScheduleDetailInfo(
      {required this.startPeriodTimestamp,
      required this.endPeriodTimestamp,
      required this.id,
      required this.scheduleId,
      required this.startPeriod,
      required this.endPeriod,
      required this.createdAt,
      required this.updatedAt,
      required this.bookingInfo,
      required this.scheduleInfo,
      required this.isBooked,
      required this.tutorInfo});

  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String scheduleId;
  final String startPeriod;
  final String endPeriod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BookingInfo>? bookingInfo;
  final ScheduleInfo? scheduleInfo;
  final bool? isBooked;
  final TutorInfo? tutorInfo;

  factory ScheduleDetailInfo.fromJson(Map<String, dynamic> json) =>
      ScheduleDetailInfo(
        startPeriodTimestamp: json["startPeriodTimestamp"],
        endPeriodTimestamp: json["endPeriodTimestamp"],
        id: json["id"],
        scheduleId: json["scheduleId"],
        startPeriod: json["startPeriod"],
        endPeriod: json["endPeriod"],
        createdAt: json["createdAt"] == null
            ? DateTime.parse("2000-01-01T00:00:00")
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.parse("2000-01-01T00:00:00")
            : DateTime.parse(json["updatedAt"]),
        bookingInfo: json["bookingInfo"] == null
            ? null
            : List<BookingInfo>.from(
                json["bookingInfo"].map((x) => BookingInfo.fromJson(x))),
        scheduleInfo: json["scheduleInfo"] == null
            ? null
            : ScheduleInfo.fromJson(json["scheduleInfo"]),
        isBooked: json["isBooked"] ?? false,
        tutorInfo: TutorInfo.fromJson(json["tutorInfo"]),
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
        "bookingInfo":
            List<BookingInfo>.from(bookingInfo!.map((x) => x.toJson())),
        "scheduleInfo": scheduleInfo!.toJson(),
        "isBooked": isBooked,
        "tutorInfo": tutorInfo!.toJson(),
      };
}
