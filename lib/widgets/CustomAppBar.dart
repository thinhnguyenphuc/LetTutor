import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key})
      : super(
          key: key,
          backgroundColor: const Color(0xFF262626),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Image.asset('assets/images/logo.png',
              fit: BoxFit.cover, width: 150, height: 150),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
        );
}
