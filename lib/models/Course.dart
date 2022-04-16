import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.reason,
    required this.purpose,
    required this.otherDetails,
    required this.defaultPrice,
    required this.coursePrice,
    required this.courseType,
    required this.sectionType,
    required this.visible,
    required this.createdAt,
    required this.updatedAt,
    required this.topics,
    required this.categories,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String level;
  final String reason;
  final String purpose;
  final String otherDetails;
  final int defaultPrice;
  final int coursePrice;
  final dynamic courseType;
  final dynamic sectionType;
  final bool visible;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Topic> topics;
  final List<Category> categories;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    level: json["level"],
    reason: json["reason"],
    purpose: json["purpose"],
    otherDetails: json["other_details"],
    defaultPrice: json["default_price"],
    coursePrice: json["course_price"],
    courseType: json["courseType"],
    sectionType: json["sectionType"],
    visible: json["visible"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "level": level,
    "reason": reason,
    "purpose": purpose,
    "other_details": otherDetails,
    "default_price": defaultPrice,
    "course_price": coursePrice,
    "courseType": courseType,
    "sectionType": sectionType,
    "visible": visible,
    "createdAt": createdAt == null ? [] : createdAt?.toIso8601String(),
    "updatedAt": updatedAt == null ? [] : updatedAt?.toIso8601String(),
    "topics": topics == [] ? null : List<dynamic>.from(topics.map((x) => x.toJson())),
    "categories": categories == [] ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final dynamic description;
  final String key;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    key: json["key"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "key": key,
    "createdAt": createdAt == null ? [] : createdAt?.toIso8601String(),
    "updatedAt": updatedAt == null ? [] : updatedAt?.toIso8601String(),
  };
}

class Topic {
  Topic({
    required this.id,
    required this.courseId,
    required this.orderCourse,
    required this.name,
    required this.nameFile,
    required this.description,
    required this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String courseId;
  final int orderCourse;
  final String name;
  final String nameFile;
  final String description;
  final dynamic videoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    courseId: json["courseId"],
    orderCourse: json["orderCourse"],
    name: json["name"],
    nameFile: json["nameFile"],
    description: json["description"],
    videoUrl: json["videoUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseId": courseId,
    "orderCourse": orderCourse,
    "name": name,
    "nameFile": nameFile,
    "description": description,
    "videoUrl": videoUrl,
    "createdAt": createdAt == null ? [] : createdAt?.toIso8601String(),
    "updatedAt": updatedAt == null ? [] : updatedAt?.toIso8601String(),
  };
}
