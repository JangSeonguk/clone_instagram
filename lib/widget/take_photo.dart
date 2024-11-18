import 'package:baby_stamp/constants/screen_size.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _controller;
  final Widget _progress = const LinearProgressIndicator(
    color: Colors.black,
    backgroundColor: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {
          return Column(children: [
            Container(
                width: screenSize.width,
                height: screenSize.width,
                color: Colors.black,
                child: (!snapshot.hasData)
                    ? _getPreview(snapshot.data)
                    : _progress),
            Expanded(
                child: SizedBox(
              height: 100,
              width: 100,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(width: 20, color: Colors.grey)),
                child: const Text(""),
              ),
            ))
          ]);
        });
  }

  Widget _getPreview(cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    return FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return _progress;
          }
        });
  }
}
