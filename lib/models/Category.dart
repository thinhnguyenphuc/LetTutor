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