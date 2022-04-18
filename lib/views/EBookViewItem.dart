import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/EBookModel.dart';

class EBookViewItem extends StatefulWidget {
  final EBook eBook;

  const EBookViewItem({Key? key, required this.eBook}) : super(key: key);

  @override
  _EBookViewItemState createState() => _EBookViewItemState();
}

class _EBookViewItemState extends State<EBookViewItem> {

  var style =  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: widget.eBook.imageUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.eBook.name,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    Text(widget.eBook.description,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20,),
                  ],
                ),
              )
            ]));
  }
}
