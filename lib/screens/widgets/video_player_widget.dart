
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({
    Key key,
    @required Future<void> initializeVideoPlayerFuture,
    @required VideoPlayerController videoController,
  }) : _initializeVideoPlayerFuture = initializeVideoPlayerFuture, _videoController = videoController, super(key: key);

  final Future<void> _initializeVideoPlayerFuture;
  final VideoPlayerController _videoController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}