import 'package:flutter/cupertino.dart';

class ClickableImage extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final void Function()? onClickedCallback;
  final BoxFit imageFit;

  ///Create an image that can be clicked on like a button
  const ClickableImage({
    Key? key,
    this.imagePath = "",
    this.imageWidth = 24,
    this.imageHeight = 24,
    this.onClickedCallback,
    this.imageFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickedCallback,
      child: Image.asset(
        imagePath,
        fit: imageFit,
        width: imageWidth,
        height: imageHeight,
      ),
    );
  }
}
