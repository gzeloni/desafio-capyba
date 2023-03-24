import 'dart:async';
// package do Flutter
import 'package:flutter/material.dart';
// Dependências do Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:desafio_capyba/core/firebase/firebase_options.dart';
// Tela CheckLogin (vide core/check_login)
import 'package:desafio_capyba/core/check_login/check_login.dart';

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
