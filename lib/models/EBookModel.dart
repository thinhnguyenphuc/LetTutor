import 'dart:convert';

import 'Category.dart';

EBook eBookFromJson(String str) => EBook.fromJson(json.decode(str));

String eBookToJson(EBook data) => json.encode(data.toJson());

class EBook {
  EBook({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.visible,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isPrivate,
    required this.createdBy,
    required this.categories,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String level;
  final bool visible;
  final String fileUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic isPrivate;
  final dynamic createdBy;
  final List<Category> categories;

  factory EBook.fromJson(Map<String, dynamic> json) => EBook(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    level: json["level"],
    visible: json["visible"],
    fileUrl: json["fileUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    isPrivate: json["isPrivate"],
    createdBy: json["createdBy"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "level": level,
    "visible": visible,
    "fileUrl": fileUrl,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isPrivate": isPrivate,
    "createdBy": createdBy,
    "categories": categories == [] ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}
