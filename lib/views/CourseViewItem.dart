import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/CourseModel.dart';

class CourseViewItem extends StatefulWidget {
  final Course course;

  const CourseViewItem({Key? key, required this.course}) : super(key: key);

  @override
  _CourseViewItemState createState() => _CourseViewItemState();
}

class _CourseViewItemState extends State<CourseViewItem> {
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
    return Container(
        margin: EdgeInsets.all(15),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: widget.course.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.course.description,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "* " + type,
                          style: style,
                        ),
                        Text(
                          "* " + widget.course.categories.first.key,
                          style: style,
                        ),
                        Text(
                            "* " +
                                widget.course.topics.length.toString() +
                                " Lessons",
                            style: style),
                      ],
                    )
                  ],
                ),
              )
            ]));
  }
}
