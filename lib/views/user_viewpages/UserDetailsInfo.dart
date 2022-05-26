import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/models/UserModel.dart';
import 'package:provider/provider.dart';

import '../../Utils.dart';
import '../../resources/BaseMixinsWidget.dart';
import '../../resources/CountryList.dart';
import '../../themes/Themes.dart';
import '../../view_models/UserViewModel.dart';

class UserDetailsInfo extends StatefulWidget {
  const UserDetailsInfo({Key? key}) : super(key: key);

  @override
  UserDetailsInfoState createState() => UserDetailsInfoState();
}

class UserDetailsInfoState extends State<UserDetailsInfo> with StateVariablesMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = Provider.of<UserViewModel>(context);
    UserClass user = viewModel.userInfo!;

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

    final List<TextEditingController> controllers = [
      nameTextEditingController,
      emailTextEditingController,
      countryTextEditingController,
      phoneTextEditingController,
      birthdayTextEditingController,
      levelTextEditingController,
      wantToLearnTextEditingController
    ];

    final List<bool> enableList = [true, false, true, false, true, true, true];

    final List<String> hintList = [
      "Name",
      "Email",
      "Country",
      "Phone",
      "Birthday",
      "Level",
      "Want to learn"
    ];

    nameTextEditingController.text = user.name;
    emailTextEditingController.text = user.email;
    countryTextEditingController.text =
    CountrySingleton().countryHashMap[user.country]!;
    phoneTextEditingController.text = user.phone;
    birthdayTextEditingController.text =
        Utils.parseDateToString(user.birthday);
    levelTextEditingController.text = user.level;

    for(LearnTopic learnTopic in user.learnTopics){
      wantToLearnTextEditingController.text = " ${learnTopic.name}";
    }


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
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
                            imageUrl: user.avatar,
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
                          child: Text(user.name,
                              style: const TextStyle(
                                  color: Color.fromRGBO(50, 50, 93, 1),
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold))),
                    ),
                    //UserLevel
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: Align(
                        child: Text(user.level,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromRGBO(82, 95, 127, 1),
                                fontSize: 17.0)),
                      ),
                    ),
                    //Region
                    Align(
                      child: Text(
                          CountrySingleton().countryHashMap[user.country]!,
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
                "Account ID: ${user.id}",
                style: const TextStyle(
                    color: ArgonColors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controllers.length,
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomTextField(
                      controller: controllers[position],
                      isEnabled: enableList[position],
                      hint: hintList[position],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                viewModel.updateInfo(
                    nameTextEditingController.text,
                    user.country,
                    phoneTextEditingController.text,
                    birthdayTextEditingController.text,
                    levelTextEditingController.text,
                    user.learnTopics,
                    user.testPreparations
                ).then(() =>Future.delayed(const Duration(milliseconds: 1500), () {
                  setState(() {});
                }));
              },
              child: Text("Save changes"),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final String hint;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.isEnabled,
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

    const disableBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(color: Colors.grey),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      child: TextField(
        enabled: isEnabled,
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          focusedBorder: focusBorder,
          enabledBorder: unFocusBorder,
          disabledBorder: disableBorder,
          hintText: hint,
          label: Text(hint),
        ),
        controller: controller,
      ),
    );
  }
}
