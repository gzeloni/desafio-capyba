import 'dart:async';
// package do Flutter
import 'package:flutter/material.dart';
// Dependências do Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:desafio_capyba/core/firebase/firebase_options.dart';
// Dependência da câmera
import 'package:camera/camera.dart';
// Tela CheckLogin (vide core/check_login)
import 'package:desafio_capyba/core/check_login/check_login.dart';

/*
 * Essa variável é global no projeto para que seja possível
 * Ler a lista de câmeras disponíveis em qualquer tela.
*/
// late CameraDescription firstCamera;

Future<void> main() async {
  // Certifique-se de que os serviços de plug-in sejam inicializados para que `availableCameras()`
  // possa ser chamado antes de `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: const CheckLogin(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
