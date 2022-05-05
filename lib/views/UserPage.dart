import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';
import '../resources/UserInfoSingleton.dart';
import 'UserDetailsInfo.dart';

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserDetailsInfo()));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        offset: Offset(0, 1), // Shadow position
                      ),
                    ]),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20, right:20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_userInfo.user.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text("My information",style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
