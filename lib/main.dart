import 'dart:async';
import 'package:camera/camera.dart';
import 'package:desafio_capyba/core/check_login/check_login.dart';
import 'package:desafio_capyba/core/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late CameraDescription firstCamera;

Future<void> main() async {
  // Certifique-se de que os serviços de plug-in sejam inicializados para que `availableCameras()`
  // possa ser chamado antes de `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Obtém uma lista das câmeras disponíveis no dispositivo.
  final cameras = await availableCameras();
  firstCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front);

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: const CheckLogin(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
