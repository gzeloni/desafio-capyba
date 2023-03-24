import 'package:camera/camera.dart';

/*
 * Essa classe pega uma lista das câmeras do dispositivo
 * Para poder usar a cãmera frontal.
*/
class GetCameraList {
  late CameraDescription firstCamera;
  getCameraList() async {
    // Obtém uma lista das câmeras disponíveis no dispositivo.
    final cameras = await availableCameras();
    // Define que firstCamera é a câmera frontal.
    firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
  }
}
