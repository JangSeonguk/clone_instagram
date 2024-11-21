import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraState extends ChangeNotifier {
  late CameraController _controller;
  late CameraDescription _cameraDescription;
  bool _readyTakePhoto = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      setCameraDescription(cameras[0]);
    }

    bool init = false;
    while (!init) {
      init = await initialize();
    }

    _readyTakePhoto = true;
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _controller =
        CameraController(_cameraDescription, ResolutionPreset.ultraHigh);
  }

  Future<bool> initialize() async {
    try {
      await _controller.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  CameraController get controller => _controller;
  CameraDescription get description => _cameraDescription;
  bool get isReadytoTakePhoto => _readyTakePhoto;
}
