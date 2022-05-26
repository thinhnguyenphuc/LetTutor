import 'UserModel.dart';

class Feedback {
  Feedback({
    required this.id,
    required this.bookingId,
    required this.firstId,
    required this.secondId,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.firstInfo,
    required this.secondInfo,
  });

  final String id;
  final String bookingId;
  final String firstId;
  final String secondId;
  final double rating;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Info? firstInfo;
  final Info? secondInfo;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json["id"],
        bookingId: json["bookingId"]??"",
        firstId: json["firstId"]??"",
        secondId: json["secondId"]??"",
        rating: json["rating"].toDouble(),
        content: json["content"]??"",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstInfo:
            (json["firstInfo"] == null || json["firstInfo"]["id"]==null)
                ? null
                : Info.fromJson(json["firstInfo"]),
        secondInfo: json["secondInfo"] == null
            ? null
            : Info.fromJson(json["secondInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "firstId": firstId,
        "secondId": secondId,
        "rating": rating,
        "content": content,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "firstInfo": firstInfo!.toJson(),
        "secondInfo": secondInfo!.toJson(),
      };
}
