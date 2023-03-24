import 'package:flutter/material.dart';

/// Mesma coisa do alert_dialog, mas um pouco mais completo.
/// Usado apenas na tela NewUser.
/// Será refatorado em breve.

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        backgroundColor: Color.fromARGB(255, 215, 254, 215),
        title: Text(
          "Algo deu errado!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 14, 31),
          ),
        ),
        content: Text(
          "Tenha certeza de que preencheu os campos corretamente e adicionou uma foto de perfil.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 1, 14, 31),
          ),
        ),
      );
    },
  );
}
