class Tutor {
  final int id;
  final String imagePath;
  final String name;
  final String countryCode;
  final double ratingStar;
  final List<String> skill;
  final String description;

  Tutor(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.countryCode,
      required this.ratingStar,
      required this.skill,
      required this.description});

  Tutor.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        imagePath = json["imagePath"],
        countryCode = json["countryCode"],
        ratingStar = json["ratingStar"],
        skill = json["skill"],
        description = json["description"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath:': imagePath,
      'countryCode': countryCode,
      'ratingStar': ratingStar,
      'skill': skill,
      'description': description
    };
  }
}
