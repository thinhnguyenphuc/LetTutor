import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/Course.dart';
import '../resources/Strings.dart';

class CourseDetailViewPage extends StatefulWidget {
  final Course course;

  const CourseDetailViewPage({Key? key, required this.course})
      : super(key: key);

  @override
  _CourseDetailsViewPageState createState() => _CourseDetailsViewPageState();
}

class _CourseDetailsViewPageState extends State<CourseDetailViewPage> {
  var style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    String type = widget.course.name.contains("Intermediate")
        ? "Intermediate"
        : widget.course.name.contains("Advanced")
            ? "Advanced"
            : widget.course.name.contains("Basic")
                ? "Basic"
                : widget.course.name.contains("Beginner")
                    ? "Beginner"
                    : "Any level";

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(2, 4), // Shadow position
                            ),
                          ]),
                      width: double.infinity,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: widget.course.imageUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.course.name,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(widget.course.description,
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Discover",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 15, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Overview",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Icon(Icons.question_mark_rounded,
                                color: Colors.red),
                            Text(Strings.whyTakeThisCourse,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25, top: 10, bottom: 10),
                          child: Text(widget.course.reason,
                              style: TextStyle(fontSize: 18)),
                        ),
                        Row(
                          children: [
                            Icon(Icons.question_mark_rounded,
                                color: Colors.red),
                            Text(Strings.whatWillYouBeAbleTodo,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 25, top: 10, bottom: 10),
                          child: Text(widget.course.purpose,
                              style: TextStyle(fontSize: 18)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Experience Level",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Icon(Icons.people_alt, color: Colors.blue),
                            Text(type,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Course Length",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Icon(Icons.topic_outlined, color: Colors.blue),
                            Text(
                                widget.course.topics.length.toString() +
                                    " topics",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("List Topics",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.course.topics.length,
                          itemBuilder: (context, position) {
                            final Topic _topic = widget.course.topics[position];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  (position + 1).toString() +
                                      ". " +
                                      _topic.name,
                                  style: TextStyle(fontSize: 20)),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ])),
      ),
    );
  }
}
