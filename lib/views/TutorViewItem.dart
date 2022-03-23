import 'package:flutter/material.dart';

import '../models/tutorModel.dart';

class TutorViewItem extends StatelessWidget {
  final Tutor tutor;

  const TutorViewItem({Key? key, required this.tutor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(tutor.name, style: const TextStyle(color: Colors.orangeAccent),),
          ]
        ),
        Row(
          children: [
            Text(tutor.countryName)
          ],
        ),
        Row(
          children: [
            Text(tutor.ratingStar.toString())
          ]
        ),
      ],
    );
  }
}
