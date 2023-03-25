import 'package:camera/camera.dart';
import 'package:desafio_capyba/core/globals/global_key.dart';
import 'package:flutter/material.dart';

/*
 * Essa classe pega uma lista das câmeras do dispositivo
 * Para poder usar a cãmera frontal.
*/
class GetCameraList {
  late CameraDescription firstCamera;
  getCameraList() async {
    try {
      // Obtém uma lista das câmeras disponíveis no dispositivo.
      final cameras = await availableCameras();
      // Define que firstCamera é a câmera frontal.
      firstCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
    } catch (e) {
      const SnackBar snackBar = SnackBar(
        content: Text("Encontramos um erro :("),
        duration: Duration(seconds: 3),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
