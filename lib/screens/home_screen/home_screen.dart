import 'package:camera/camera.dart';
import 'package:camerafy/screens/widgets/draggable_camera_widget.dart';
import 'package:camerafy/screens/widgets/video_player_widget.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> cameras;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DragController _dragController = DragController();

  CameraController _cameraController;

  VideoPlayerController _videoController;
  Future<void> _initializeVideoPlayerFuture;
  double _sliderValue = 1.0;

  Future<void> _initializeCameras() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  _initializeVideo(){
    _videoController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();
  }

  @override
  void initState() {
    _initializeCameras();
    _initializeVideo();

    super.initState();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _videoController?.pause();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cameraController != null
          ? _cameraController.initialize()
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: VideoPlayerWidget(initializeVideoPlayerFuture: _initializeVideoPlayerFuture, videoController: _videoController),
        ),
        Positioned.directional(
          start: 20,
          textDirection: TextDirection.ltr,
          child: RotatedBox(
            quarterTurns: 3,
            child: Slider(
              activeColor: Colors.indigoAccent,
              min: 0.0,
              max: 1.0,
              onChanged: (newRating) async {
                setState(() {
                  _sliderValue = newRating;
                });
                await setVol(newRating);
              },
              value: _sliderValue,
            ),
          ),
        ),
        DraggableCameraWidget(cameraController: _cameraController, dragController: _dragController),
      ]),
    );
  }

  setVol(double i) async {
    await _videoController.setVolume(i);
  }
}



