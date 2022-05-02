import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.user,
    required this.tokens,
  });

  final UserClass user;
  final Tokens tokens;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "tokens": tokens.toJson(),
      };
}

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
    required this.walletInfo,
    required this.courses,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
  });

  final String id;
  final String email;
  final String name;
  final String avatar;
  final String country;
  final String phone;
  final List<String> roles;
  final dynamic language;
  final DateTime birthday;
  final bool isActivated;
  final WalletInfo walletInfo;
  final List<dynamic> courses;
  final dynamic requireNote;
  final String level;
  final List<dynamic> learnTopics;
  final List<dynamic> testPreparations;
  final bool isPhoneActivated;
  final int timezone;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        country: json["country"],
        phone: json["phone"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        language: json["language"],
        birthday: DateTime.parse(json["birthday"]),
        isActivated: json["isActivated"],
        walletInfo: WalletInfo.fromJson(json["walletInfo"]),
        courses: List<dynamic>.from(json["courses"].map((x) => x)),
        requireNote: json["requireNote"],
        level: json["level"],
        learnTopics: List<dynamic>.from(json["learnTopics"].map((x) => x)),
        testPreparations:
            List<dynamic>.from(json["testPreparations"].map((x) => x)),
        isPhoneActivated: json["isPhoneActivated"],
        timezone: json["timezone"],
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
        "walletInfo": walletInfo.toJson(),
        "courses": List<dynamic>.from(courses.map((x) => x)),
        "requireNote": requireNote,
        "level": level,
        "learnTopics": List<dynamic>.from(learnTopics.map((x) => x)),
        "testPreparations": List<dynamic>.from(testPreparations.map((x) => x)),
        "isPhoneActivated": isPhoneActivated,
        "timezone": timezone,
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
