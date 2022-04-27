import 'dart:convert';

BookingInfo bookingInfoFromJson(String str) =>
    BookingInfo.fromJson(json.decode(str));

String bookingInfoToJson(BookingInfo data) => json.encode(data.toJson());

class BookingInfo {
  BookingInfo({
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
  });

  final int createdAtTimeStamp;
  final int updatedAtTimeStamp;
  final int id;
  final String userId;
  final String scheduleDetailId;
  final String tutorMeetingLink;
  final String studentMeetingLink;
  final dynamic studentRequest;
  final dynamic tutorReview;
  final dynamic scoreByTutor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic recordUrl;
  final bool isDeleted;

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
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
      };
}
