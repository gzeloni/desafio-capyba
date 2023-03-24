import 'package:camera/camera.dart';

class GetCameraList {
  late CameraDescription firstCamera;
  getCameraList() async {
    // Obtém uma lista das câmeras disponíveis no dispositivo.
    final cameras = await availableCameras();
    firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
  }
}
