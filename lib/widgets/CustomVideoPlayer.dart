import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const CustomVideoPlayer({
    Key? key,
    required this.videoPlayerController,
    required this.looping,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late ChewieController _chewieController;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    widget.videoPlayerController
      .initialize().then((_) {
      isReady = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      looping: widget.looping,
    );

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isReady
            ? FittedBox(
                fit: BoxFit.fitHeight,
                child: Chewie(
                  controller: _chewieController,
                ),
              )
            : const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ));
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
