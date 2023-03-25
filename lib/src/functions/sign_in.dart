// package do Flutter

import 'package:flutter/material.dart';
// Dependência do Firebase
import 'package:firebase_auth/firebase_auth.dart';
// NavBar LoadingWindow
import 'package:desafio_capyba/src/models/loading_windows/loading_window.dart';

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
        Navigator.pushNamedAndRemoveUntil(context, '/navbar', (route) => true);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
    }
  }
}
