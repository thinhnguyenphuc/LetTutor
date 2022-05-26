import 'dart:convert';

import 'FeedBackModel.dart';
import 'TestPreparation.dart';
import 'TutorModel.dart';

class Tokens {
  Tokens({
    required this.access,
    required this.refresh,
  });

  final Access access;
  final Access refresh;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: Access.fromJson(json["access"]),
        refresh: Access.fromJson(json["refresh"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access.toJson(),
        "refresh": refresh.toJson(),
      };
}

class Access {
  Access({
    required this.token,
    required this.expires,
  });

  final String token;
  final DateTime expires;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires.toIso8601String(),
      };
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.user,
  });

  final UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.roles,
    required this.language,
    required this.birthday,
    required this.isActivated,
    required this.tutorInfo,
    required this.walletInfo,
    required this.feedbacks,
    required this.courses,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
    required this.referralInfo,
    required this.avgRating,
    required this.priceOfEachSession,
  });

  final String id;
  final String email;
  final String name;
  final String avatar;
  final String country;
  final String phone;
  final List<String> roles;
  final String language;
  final DateTime birthday;
  final bool isActivated;
  final TutorInfo? tutorInfo;
  final WalletInfo? walletInfo;
  final List<Feedback> feedbacks;
  final List<dynamic> courses;
  final dynamic requireNote;
  final String level;
  final List<LearnTopic> learnTopics;
  final List<TestPreparation> testPreparations;
  final bool isPhoneActivated;
  final int timezone;
  final ReferralInfo? referralInfo;
  final double avgRating;
  final PriceOfEachSession? priceOfEachSession;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        country: json["country"]??"",
        phone: json["phone"]??"",
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"].map((x) => x)),
        language: json["language"]??"",
        birthday: DateTime.parse(json["birthday"] ?? "2000-01-01"),
        isActivated: json["isActivated"]??false,
        tutorInfo: (json["tutorInfo"] == null || json["tutorInfo"]["level"] == null)
            ? null
            : TutorInfo.fromJson(json["tutorInfo"]),
        walletInfo: json["walletInfo"] == null
            ? null
            : WalletInfo.fromJson(json["walletInfo"]),
        feedbacks: json["feedbacks"] == null
            ? []
            : List<Feedback>.from(
                json["feedbacks"].map((x) => Feedback.fromJson(x))),
        courses: json["courses"] == null
            ? []
            : List<dynamic>.from(json["courses"].map((x) => x)),
        requireNote: json["requireNote"]??"",
        level: json["level"]??"",
        learnTopics: json["learnTopics"] == null
            ? []
            : List<LearnTopic>.from(
                json["learnTopics"].map((x) => LearnTopic.fromJson(x))),
        testPreparations: json["testPreparations"] == null
            ? []
            : List<TestPreparation>.from(
                json["testPreparations"].map((x) => LearnTopic.fromJson(x))),
        isPhoneActivated: json["isPhoneActivated"]??false,
        timezone: json["timezone"]??7,
        referralInfo: json["referralInfo"] == null
            ? null
            : ReferralInfo.fromJson(json["referralInfo"]),
        avgRating: (json["avgRating"] ?? 5).toDouble(),
        priceOfEachSession: json["priceOfEachSession"] == null
            ? null
            : PriceOfEachSession.fromJson(json["priceOfEachSession"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "avatar": avatar,
        "country": country,
        "phone": phone,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "language": language,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "isActivated": isActivated,
        "tutorInfo": tutorInfo == null ? null : tutorInfo!.toJson(),
        "walletInfo": walletInfo == null ? null : walletInfo!.toJson(),
        "feedbacks": List<dynamic>.from(feedbacks.map((x) => x.toJson())),
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "requireNote": requireNote,
        "level": level,
        "learnTopics": List<dynamic>.from(learnTopics.map((x) => x.toJson())),
        "testPreparations":
            List<dynamic>.from(testPreparations.map((x) => x.toJson())),
        "isPhoneActivated": isPhoneActivated,
        "timezone": timezone,
        "referralInfo": referralInfo == null ? null : referralInfo!.toJson(),
        "avgRating": avgRating,
        "priceOfEachSession":
            priceOfEachSession ?? priceOfEachSession!.toJson(),
      };
}

class Info {
  Info({
    required this.id,
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

  final String id;
  final String level;
  final String email;
  final dynamic google;
  final dynamic facebook;
  final dynamic apple;
  final String avatar;
  final String name;
  final String country;
  final String phone;
  final String language;
  final DateTime birthday;
  final bool requestPassword;
  final bool isActivated;
  final bool isPhoneActivated;
  final dynamic requireNote;
  final int timezone;
  final dynamic phoneAuth;
  final bool isPhoneAuthActivated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"]??"",
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
        birthday: json["birthday"] == null
            ? DateTime.parse("2000-01-01")
            : DateTime.tryParse(json["birthday"]) ??
                DateTime.parse("2000-01-01"),
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
        "id": id,
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
      };
}

class LearnTopic {
  LearnTopic({
    required this.id,
    required this.key,
    required this.name,
  });

  final int id;
  final String key;
  final String name;

  factory LearnTopic.fromJson(Map<String, dynamic> json) => LearnTopic(
        id: json["id"],
        key: json["key"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "name": name,
      };
}

class PriceOfEachSession {
  PriceOfEachSession({
    required this.id,
    required this.key,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String key;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory PriceOfEachSession.fromJson(Map<String, dynamic> json) =>
      PriceOfEachSession(
        id: json["id"],
        key: json["key"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class ReferralInfo {
  ReferralInfo({
    required this.id,
    required this.referralCode,
    required this.userId,
    required this.referralPackId,
    required this.createdAt,
    required this.updatedAt,
    required this.referralPackInfo,
  });

  final int id;
  final String referralCode;
  final String userId;
  final int referralPackId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ReferralPackInfo referralPackInfo;

  factory ReferralInfo.fromJson(Map<String, dynamic> json) => ReferralInfo(
        id: json["id"],
        referralCode: json["referralCode"],
        userId: json["userId"],
        referralPackId: json["referralPackId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        referralPackInfo: ReferralPackInfo.fromJson(json["referralPackInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "referralCode": referralCode,
        "userId": userId,
        "referralPackId": referralPackId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "referralPackInfo": referralPackInfo.toJson(),
      };
}

class ReferralPackInfo {
  ReferralPackInfo({
    required this.id,
    required this.earnPercent,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int earnPercent;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ReferralPackInfo.fromJson(Map<String, dynamic> json) =>
      ReferralPackInfo(
        id: json["id"],
        earnPercent: json["earnPercent"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "earnPercent": earnPercent,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class WalletInfo {
  WalletInfo({
    required this.id,
    required this.userId,
    required this.amount,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    required this.bonus,
  });

  final String id;
  final String userId;
  final String amount;
  final bool isBlocked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int bonus;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        id: json["id"],
        userId: json["userId"],
        amount: json["amount"],
        isBlocked: json["isBlocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bonus: json["bonus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "amount": amount,
        "isBlocked": isBlocked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "bonus": bonus,
      };
}
