import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/models/UserModel.dart';

import '../../Utils.dart';
import '../../resources/CountryList.dart';
import '../../themes/Themes.dart';

class UserDetailsInfo extends StatelessWidget {
  final UserClass? user;

  const UserDetailsInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameTextEditingController =
        TextEditingController();
    final TextEditingController emailTextEditingController =
        TextEditingController();
    final TextEditingController countryTextEditingController =
        TextEditingController();
    final TextEditingController phoneTextEditingController =
        TextEditingController();
    final TextEditingController birthdayTextEditingController =
        TextEditingController();
    final TextEditingController levelTextEditingController =
        TextEditingController();
    final TextEditingController wantToLearnTextEditingController =
        TextEditingController();

    nameTextEditingController.text = user!.name;
    emailTextEditingController.text = user!.email;
    countryTextEditingController.text = user!.country;
    phoneTextEditingController.text = user!.phone;
    birthdayTextEditingController.text =
        Utils.parseDateToString(user!.birthday);
    levelTextEditingController.text = user!.level;
    wantToLearnTextEditingController.text = "user!.learnTopics.first.name";

    

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              imageUrl: user!.avatar,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                  Column(
                    children: [
                      //UserName
                      Align(
                        alignment: Alignment.center,
                        child: Hero(
                            tag: "name",
                            child: Text(user!.name,
                                style: const TextStyle(
                                    color: Color.fromRGBO(50, 50, 93, 1),
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold))),
                      ),
                      //UserLevel
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                        child: Align(
                          child: Text(user!.level,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color.fromRGBO(82, 95, 127, 1),
                                  fontSize: 17.0)),
                        ),
                      ),
                      //Region
                      Align(
                        child: Text(
                            CountrySingleton().countryHashMap[user!.country]!,
                            style: const TextStyle(
                                color: Color.fromRGBO(50, 50, 93, 1),
                                fontSize: 18.0)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20)
                ],
              ),
              //Account ID
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Text(
                  "Account ID: ${user!.id}",
                  style: const TextStyle(
                      color: ArgonColors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Divider(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isDisabled;
  final String hint;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.isDisabled,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const unFocusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Colors.green),
    );

    const focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Colors.red),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      child: TextField(
        enabled: isDisabled,
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          focusedBorder: focusBorder,
          enabledBorder: unFocusBorder,
          hintText: hint,
          label: Text(hint),
        ),
        controller: controller,
      ),
    );
  }
}
