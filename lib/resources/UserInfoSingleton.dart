import '../models/UserModel.dart';

class UserInfoLazyInitializedSingleton {
  static UserInfoLazyInitializedSingleton? _instance =
      UserInfoLazyInitializedSingleton._privateConstructor();

  UserInfoLazyInitializedSingleton._privateConstructor();

  static late final User _userInfo;

  factory UserInfoLazyInitializedSingleton() {
    _instance ??= UserInfoLazyInitializedSingleton._privateConstructor();
    return _instance!;
  }

  void setUserInfo(User user) {
    _userInfo = user;
  }

  User getUserInfo() {
    return _userInfo;
  }

  String getToken() {
    return _userInfo.tokens.access.token;
  }
}
