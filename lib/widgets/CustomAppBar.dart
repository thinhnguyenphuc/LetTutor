import 'package:flutter/material.dart';
import 'package:project/widgets/HeroAnimation.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(IconHero logo, {Key? key})
      : super(
          key: key,
          backgroundColor: const Color(0xFF262626),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: logo,
          actions: [
            IconButton(
                icon: const Icon(Icons.message_outlined), onPressed: () {}),
          ],
        );
}
