import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/TutorModel.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/HeroAnimation.dart';

class TutorDetailsPage extends StatefulWidget {
  final TutorInfo tutor;
  const TutorDetailsPage({Key? key, required this.tutor}) : super(key: key);

  @override
  _TutorDetailsPageState createState() => _TutorDetailsPageState();
}

class _TutorDetailsPageState extends State<TutorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final logo = IconHero(
      tag: 'logo',
      child: Image.asset('assets/images/logo.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 5),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45,
                  child: ClipOval(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: CachedNetworkImage(
                        imageUrl: widget.tutor.avatar,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
