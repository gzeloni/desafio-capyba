import 'dart:async';
import 'package:desafio_capyba/core/globals/globals.dart';
import 'package:desafio_capyba/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:desafio_capyba/core/firebase/firebase_options.dart';
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
      scaffoldMessengerKey: snackbarKey,
      routes: routes,
      initialRoute: '/checkLogin',
      debugShowCheckedModeBanner: false,
    ),
  );
}
