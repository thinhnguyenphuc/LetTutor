
import 'EBookModel.dart';


class StudentMaterial {
  StudentMaterial({
    required this.id,
    required this.studentId,
    required this.eBookId,
    required this.topicId,
    required this.bookingId,
    required this.currentPage,
    required this.latestDate,
    required this.createdAt,
    required this.updatedAt,
    required this.eBook,
  });

  final int id;
  final String studentId;
  final String eBookId;
  final dynamic topicId;
  final String bookingId;
  final int currentPage;
  final DateTime latestDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final EBook eBook;

  factory StudentMaterial.fromJson(Map<String, dynamic> json) => StudentMaterial(
    id: json["id"],
    studentId: json["studentId"],
    eBookId: json["eBookId"],
    topicId: json["topicId"],
    bookingId: json["bookingId"],
    currentPage: json["currentPage"],
    latestDate: DateTime.parse(json["latestDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    eBook: EBook.fromJson(json["eBook"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentId": studentId,
    "eBookId": eBookId,
    "topicId": topicId,
    "bookingId": bookingId,
    "currentPage": currentPage,
    "latestDate": latestDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "eBook": eBook.toJson(),
  };
}