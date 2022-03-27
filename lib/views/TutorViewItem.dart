import 'package:flutter/material.dart';
import '../models/tutorModel.dart';
import 'package:flag/flag.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../resources/CountryList.dart';

class TutorViewItem extends StatelessWidget {
  final Tutor tutor;

  const TutorViewItem({Key? key, required this.tutor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var countryName = CountrySingleton().countryHashMap[tutor.countryCode];
    final localNameView =
        countryName != null ? Text(countryName) : const Text("Null");
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(2, 4), // Shadow position
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 45,
                      child: ClipOval(
                        child: Image.network(
                          tutor.imagePath,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      tutor.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ]),
                  Row(
                    children: [
                      Flag.fromString(
                        tutor.countryCode,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 10),
                      localNameView,
                    ],
                  ),
                  Row(children: [
                    RatingBar.builder(
                      itemSize: 15,
                      initialRating: tutor.ratingStar,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {},
                    )
                  ]),
                ],
              ),
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Wrap(
                        children: <Widget>[
                          for (String skill in tutor.skill)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 2, 5),
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue.shade500),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(skill),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Text(tutor.description,
                      style: TextStyle(color: Colors.grey.shade700)),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: const BorderSide(width: 5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.today_outlined),
                        Text("Book"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: const BorderSide(width: 5, color: Colors.blue),
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.message_outlined),
                        Text("Message"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
