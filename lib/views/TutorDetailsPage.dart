import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_viewer/video_viewer.dart';

import '../models/TutorModel.dart';
import '../resources/CountryList.dart';
import '../resources/Specialties.dart';

class TutorDetailsPage extends StatefulWidget {
  final TutorInfo tutor;

  const TutorDetailsPage({Key? key, required this.tutor}) : super(key: key);

  @override
  _TutorDetailsPageState createState() => _TutorDetailsPageState();
}

class _TutorDetailsPageState extends State<TutorDetailsPage> {
  var titleTextStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final VideoViewerController controller = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    var countryName = CountrySingleton().countryHashMap[widget.tutor.country];
    List<String> languages = widget.tutor.getLanguages(context);

    final localNameView = countryName != null
        ? Text(
            countryName,
            style: TextStyle(fontSize: 20),
          )
        : const Text("Null");
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 80,
                          child: ClipOval(
                            child: SizedBox(
                              width: 300,
                              height: 300,
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            widget.tutor.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ]),
                        Row(children: [
                          RatingBar.builder(
                            itemSize: 30,
                            initialRating: widget.tutor.getRating(),
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
                        Row(
                          children: [
                            Flag.fromString(
                              widget.tutor.country,
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(width: 10),
                            localNameView,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Education", style: titleTextStyle),
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
                                  for (String education
                                      in widget.tutor.education.split(","))
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 2, 5),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          color: Colors.lightBlueAccent,
                                        ),
                                        child: Text(education),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ExpandableNotifier(
                  child: Expandable(
                collapsed: ExpandableButton(
                  child: Column(
                    children: [
                      Text(
                        widget.tutor.bio,
                        maxLines: 5,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade600),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "More",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                expanded: ExpandableButton(
                  child: Column(
                    children: [
                      Text(
                        widget.tutor.bio,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade800),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Less",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: const [
                        Icon(Icons.message),
                        Text(
                          'Message',
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Text(
                          'Favorite',
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: const [
                        Icon(Icons.report_gmailerrorred_sharp),
                        Text(
                          'Report',
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: const [
                        Icon(Icons.star),
                        Text(
                          'Reviews',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            ExpandableNotifier(
              child: Expandable(
                  collapsed: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ExpandableButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Video introduce", style: titleTextStyle),
                              const Icon(Icons.arrow_downward_rounded),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: VideoViewer(
                            controller: controller,
                            source: {
                              "SubRip Text": VideoSource(
                                video: VideoPlayerController.network(
                                    widget.tutor.video),
                              )
                            },
                          ))
                    ],
                  ),
                  expanded: ExpandableButton(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Video introduce",
                          style: titleTextStyle,
                        ),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Languages", style: titleTextStyle),
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
                                  for (String language in languages)
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 2, 5),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          color: Colors.greenAccent,
                                        ),
                                        child: Text(language),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Specialties", style: titleTextStyle),
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
                                  for (String skill
                                      in widget.tutor.specialties.split(","))
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 2, 5),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Interests", style: titleTextStyle),
                    ],
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 5),
                          child: Text(
                            widget.tutor.interests,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Teaching experience", style: titleTextStyle),
                    ],
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 5),
                          child: Text(
                            widget.tutor.experience,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ]),
        ));
  }
}
