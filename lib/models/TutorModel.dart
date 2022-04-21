import 'dart:convert';

List<TutorInfo> tutorFromJson(String str) =>
    List<TutorInfo>.from(json.decode(str).map((x) => TutorInfo.fromJson(x)));

String tutorToJson(List<TutorInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TutorInfo {
  TutorInfo({
    required this.level,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.avatar,
    required this.name,
    required this.country,
    required this.phone,
    required this.language,
    required this.birthday,
    required this.requestPassword,
    required this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    required this.timezone,
    this.phoneAuth,
    required this.isPhoneAuthActivated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.feedbacks,
    required this.schedules,
    required this.id,
    required this.userId,
    required this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    this.accent,
    required this.targetStudent,
    required this.interests,
    required this.languages,
    this.specialties = "",
    this.resume,
    this.isNative,
    required this.price,
  });

  final String level;
  final String email;
  final dynamic google;
  final dynamic facebook;
  final dynamic apple;
  final String avatar;
  final String name;
  final String country;
  final String phone;
  final dynamic language;
  final DateTime birthday;
  final bool requestPassword;
  final bool isActivated;
  final dynamic isPhoneActivated;
  final dynamic requireNote;
  final int timezone;
  final dynamic phoneAuth;
  final bool isPhoneAuthActivated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final List<Feedback> feedbacks;
  final List<dynamic> schedules;
  final String id;
  final String userId;
  final String video;
  final String bio;
  final String education;
  final String experience;
  final String profession;
  final dynamic accent;
  final String targetStudent;
  final String interests;
  final String languages;
  final String specialties;
  final dynamic resume;
  final dynamic isNative;
  final int price;

  factory TutorInfo.fromJson(Map<String, dynamic> json) => TutorInfo(
        level: json["level"],
        email: json["email"],
        google: json["google"],
        facebook: json["facebook"],
        apple: json["apple"],
        avatar: json["avatar"],
        name: json["name"],
        country: json["country"],
        phone: json["phone"],
        language: json["language"],
        birthday: DateTime.parse(json["birthday"]),
        requestPassword: json["requestPassword"],
        isActivated: json["isActivated"],
        isPhoneActivated: json["isPhoneActivated"],
        requireNote: json["requireNote"],
        timezone: json["timezone"],
        phoneAuth: json["phoneAuth"],
        isPhoneAuthActivated: json["isPhoneAuthActivated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        feedbacks: json["feedbacks"] != null
            ? List<Feedback>.from(
                json["feedbacks"].map((x) => Feedback.fromJson(x)))
            : [],
        schedules: json["schedules"] != null
            ? List<dynamic>.from(json["schedules"].map((x) => x))
            : [],
        id: json["id"],
        userId: json["userId"] ?? "",
        video: json["video"] ?? "",
        bio: json["bio"] ?? "",
        education: json["education"] ?? "",
        experience: json["experience"] ?? "",
        profession: json["profession"] ?? "",
        accent: json["accent"] ?? "",
        targetStudent: json["targetStudent"] ?? "",
        interests: json["interests"] ?? "",
        languages: json["languages"] ?? "",
        specialties: json["specialties"] ?? "",
        resume: json["resume"] ?? "",
        isNative: json["isNative"] ?? "",
        price: json["price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "email": email,
        "google": google,
        "facebook": facebook,
        "apple": apple,
        "avatar": avatar,
        "name": name,
        "country": country,
        "phone": phone,
        "language": language,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "requestPassword": requestPassword,
        "isActivated": isActivated,
        "isPhoneActivated": isPhoneActivated,
        "requireNote": requireNote,
        "timezone": timezone,
        "phoneAuth": phoneAuth,
        "isPhoneAuthActivated": isPhoneAuthActivated,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "feedbacks": List<dynamic>.from(feedbacks.map((x) => x.toJson())),
        "schedules": List<dynamic>.from(schedules.map((x) => x)),
        "id": id,
        "userId": userId,
        "video": video,
        "bio": bio,
        "education": education,
        "experience": experience,
        "profession": profession,
        "accent": accent,
        "targetStudent": targetStudent,
        "interests": interests,
        "languages": languages,
        "specialties": specialties,
        "resume": resume,
        "isNative": isNative,
        "price": price,
      };
}

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
  });

  final String id;
  final String? bookingId;
  final String firstId;
  final String secondId;
  final int rating;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FirstInfo firstInfo;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json["id"],
        bookingId: json["bookingId"],
        firstId: json["firstId"],
        secondId: json["secondId"],
        rating: json["rating"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstInfo: FirstInfo.fromJson(json["firstInfo"]),
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
        "firstInfo": firstInfo.toJson(),
      };
}

class FirstInfo {
  FirstInfo({
    required this.level,
    required this.email,
    required this.google,
    required this.facebook,
    required this.apple,
    required this.avatar,
    required this.name,
    required this.country,
    required this.phone,
    required this.language,
    required this.birthday,
    required this.requestPassword,
    required this.isActivated,
    required this.isPhoneActivated,
    required this.requireNote,
    required this.timezone,
    required this.phoneAuth,
    required this.isPhoneAuthActivated,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String? level;
  final String email;
  final dynamic google;
  final dynamic facebook;
  final dynamic apple;
  final String avatar;
  final String name;
  final String? country;
  final String? phone;
  final String? language;
  final String? birthday;
  final bool requestPassword;
  final bool isActivated;
  final bool? isPhoneActivated;
  final dynamic requireNote;
  final int? timezone;
  final dynamic phoneAuth;
  final bool isPhoneAuthActivated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory FirstInfo.fromJson(Map<String, dynamic> json) => FirstInfo(
        level: json["level"],
        email: json["email"],
        google: json["google"],
        facebook: json["facebook"],
        apple: json["apple"],
        avatar: json["avatar"],
        name: json["name"],
        country: json["country"],
        phone: json["phone"],
        language: json["language"],
        birthday: json["birthday"],
        requestPassword: json["requestPassword"],
        isActivated: json["isActivated"],
        isPhoneActivated: json["isPhoneActivated"],
        requireNote: json["requireNote"],
        timezone: json["timezone"],
        phoneAuth: json["phoneAuth"],
        isPhoneAuthActivated: json["isPhoneAuthActivated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "email": email,
        "google": google,
        "facebook": facebook,
        "apple": apple,
        "avatar": avatar,
        "name": name,
        "country": country,
        "phone": phone,
        "language": language,
        "birthday": birthday,
        "requestPassword": requestPassword,
        "isActivated": isActivated,
        "isPhoneActivated": isPhoneActivated,
        "requireNote": requireNote,
        "timezone": timezone,
        "phoneAuth": phoneAuth,
        "isPhoneAuthActivated": isPhoneAuthActivated,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
