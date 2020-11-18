import 'package:camera/camera.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';

class DraggableCameraWidget extends StatelessWidget {
  const DraggableCameraWidget({
    Key key,
    @required this.cameraController,
    @required this.dragController,
  }) : super(key: key);

  final CameraController cameraController;
  final DragController dragController;

  @override
  Widget build(BuildContext context) {
    return DraggableWidget(
      bottomMargin: 40,
      topMargin: 20,
      intialVisibility: true,
      horizontalSapce: 20,
      child: RotatedBox(
        quarterTurns: 3,
        child: SizedBox(
          height: 150,
          width: 100,
          child: cameraController.value != null
              ? cameraController.value.isInitialized
              ? AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: CameraPreview(cameraController),
          )
              : Container(
            color: Colors.grey.shade200,
            child: Icon(Icons.videocam_off_outlined),
          )
              : Container(
            color: Colors.grey.shade200,
            child: Icon(Icons.videocam_off_outlined),
          ),
        ),
      ),
      initialPosition: AnchoringPosition.bottomRight,
      dragController: dragController,
    );
  }
}