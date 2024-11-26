import 'dart:io';

import 'package:baby_stamp/constants/screen_size.dart';
import 'package:baby_stamp/models/camera_state.dart';
import 'package:baby_stamp/screen/share_post_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  final Widget _progress = const LinearProgressIndicator(
    color: Colors.black,
    backgroundColor: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (context, CameraState cameraState, child) {
        return Column(children: [
          Container(
              width: screenSize.width,
              height: screenSize.width,
              color: Colors.black,
              child: (cameraState.isReadytoTakePhoto)
                  ? _getPreview(cameraState)
                  : _progress),
          Expanded(
              child: SizedBox(
            height: 100,
            width: 100,
            child: OutlinedButton(
              onPressed: () {
                if (cameraState.isReadytoTakePhoto) {
                  _attemptTakePhoto(cameraState, context);
                }
              },
              style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: const BorderSide(width: 20, color: Colors.grey)),
              child: const Text(""),
            ),
          ))
        ]);
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
              width: screenSize.width,
              //aspectRatio : 너비/높이
              height: screenSize.height,
              // height: screenSißze.width / _controller.value.aspectRatio,
              child: CameraPreview(cameraState.controller)),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final path =
          join((await getTemporaryDirectory()).path, "$timeInMilli.png");
      final picture = await cameraState.controller.takePicture();
      if (!mounted) return;

      // 촬영된 사진을 원하는 경로로 복사
      await File(picture.path).copy(path);

      File imageFile = File(path);
      if (context.mounted) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SharePostScreen(imageFile: imageFile)));
      }
    } catch (e) {}
  }
}
