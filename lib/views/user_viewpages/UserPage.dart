import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/models/UserModel.dart';
import 'package:project/resources/UserInfoSingleton.dart';
import 'package:project/view_models/WalletViewModel.dart';
import 'package:project/views/user_viewpages/UserDetailsInfo.dart';
import 'package:project/views/user_viewpages/WalletPage.dart';
class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  final User _userInfo = UserInfoLazyInitializedSingleton().getUserInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
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
                            imageUrl: _userInfo.user.avatar,
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
                  child: Text(_userInfo.user.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                Text("Level: " + _userInfo.user.level,
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserDetailsInfo()));
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
                            children: const [
                              Text("Edit my information",
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
                            children: const [
                              Text("My wallet", style: TextStyle(fontSize: 16)),
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
                            builder: (context) => const UserDetailsInfo()));
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
                            children: const [
                              Text("Languages", style: TextStyle(fontSize: 16)),
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
                            builder: (context) => const UserDetailsInfo()));
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
                          child: Icon(Icons.dark_mode),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Dark theme",
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
                            builder: (context) => const UserDetailsInfo()));
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
                          child: Icon(Icons.password),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Change password",
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
                            builder: (context) => const UserDetailsInfo()));
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
                          child: Icon(Icons.settings),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Settings", style: TextStyle(fontSize: 16)),
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
                            builder: (context) => const UserDetailsInfo()));
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
                          child: Icon(Icons.logout),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Logout", style: TextStyle(fontSize: 16)),
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
