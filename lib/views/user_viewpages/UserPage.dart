import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/Utils.dart';
import 'package:project/models/UserModel.dart';
import 'package:project/provider/locale_provider.dart';
import 'package:project/views/user_viewpages/UserDetailsInfo.dart';
import 'package:project/views/user_viewpages/WalletPage.dart';
import 'package:provider/provider.dart';

import '../../resources/BaseMixinsWidget.dart';
import '../../view_models/UserViewModel.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> with StateVariablesMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userInfoProvider = Provider.of<UserViewModel>(context);
    bool isLoaded = userInfoProvider.isFetching;
    UserClass? userInfo = userInfoProvider.userInfo;

    final _userContainer = isLoaded && userInfo != null
        ? Container(
            margin: const EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              children: [
                Hero(
                    tag: "avatar",
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 65,
                      child: ClipOval(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: CachedNetworkImage(
                            imageUrl: userInfo.avatar,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )),
                Hero(
                  tag: "name",
                  child: Text(userInfo.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                Text("${l10n.level}: " + userInfo.level,
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          )
        : const Center(
            child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _userContainer,
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Utils.showReviewsDialog(context, userInfo!.feedbacks);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.reviews),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.review,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const UserDetailsInfo()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.edit),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.editInfo,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WalletPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.wallet),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.paymentHistory,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),

                //Languages
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          l10n.language,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<LocaleProvider>()
                                                .setLocale(const Locale("vi"));
                                          },
                                          icon: Image.asset(
                                            "assets/icon/vietnam.png",
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<LocaleProvider>()
                                                .setLocale(const Locale("en"));
                                          },
                                          icon: Image.asset(
                                            "assets/icon/united-kingdom.png",
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.language),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.language,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),

                //Themes
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.dark_mode),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.chooseThemeTitle,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),

                //ChangePassword
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.password),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.changePasswordBtnText,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),

                //Settings
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.settings),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.settingsTitle,
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),

                //Logout
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.logout),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.logout, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
