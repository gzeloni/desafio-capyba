// package do Flutter
import 'package:desafio_capyba/src/models/alert_dialogs/custom_snack_bar.dart';
import 'package:flutter/material.dart';
// Dependência do Firebase
import 'package:firebase_auth/firebase_auth.dart';
// NavBar e LoadingWindow
import 'package:desafio_capyba/src/models/loading_windows/loading_window.dart';
import 'package:desafio_capyba/src/navbar/navbar.dart';

class SignIn {
  /// Essas variáveis recebem dados da
  /// tela de Login.
  String email;
  String password;
  BuildContext context;

  SignIn({
    required this.email,
    required this.password,
    required this.context,
  });

  Future signIn() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        },
      );
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NavBar()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      CustomScaffoldMessenger(
        error: e.toString(),
      );
    }
  }
}
