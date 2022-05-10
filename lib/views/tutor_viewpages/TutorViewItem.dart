import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/models/TutorModel.dart';
import 'package:project/resources/CountryList.dart';
import 'package:project/resources/Specialties.dart';
import 'package:project/view_models/TutorViewModel.dart';
import 'package:project/views/booking_viewpages/BookingPage.dart';

class TutorViewItem extends StatelessWidget {
  final TutorInfo tutor;
  final TutorViewModel tutorViewModel;

  const TutorViewItem(
      {Key? key, required this.tutor, required this.tutorViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var countryName = CountrySingleton().countryHashMap[tutor.country];
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
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: CachedNetworkImage(
                            imageUrl: tutor.avatar,
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
                        tutor.country,
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
                      initialRating: tutor.getRating(),
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
                          for (String skill in tutor.specialties.split(","))
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 2, 5),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  color: Colors.greenAccent,
                                ),
                                child: Text(getSkillByKey(skill)),
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
                  child: Text(tutor.bio,
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingPage(
                                tutor: tutor,
                                tutorViewModel: tutorViewModel,
                              )));
                    },
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
