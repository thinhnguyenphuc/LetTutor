// To parse this JSON data, do
//
//     final testPreparation = testPreparationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TestPreparation> testPreparationFromJson(String str) => List<TestPreparation>.from(json.decode(str).map((x) => TestPreparation.fromJson(x)));

String testPreparationToJson(List<TestPreparation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestPreparation {
  TestPreparation({
    required this.id,
    required this.key,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String key;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory TestPreparation.fromJson(Map<String, dynamic> json) => TestPreparation(
    id: json["id"],
    key: json["key"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "name": name,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
