// package do Flutter
import 'package:flutter/material.dart';
// Dependência do Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
// Telas: Login e Navbar (explicada mais abaixo)
import 'package:desafio_capyba/src/navbar/navbar.dart';
import 'package:desafio_capyba/src/screens/login_page.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /// A NavBar compõe a tela e mantém uma barra de navegação
            /// na base da tela.
            /// Retornar a NavBar, retorna diretamente a Home e também
            /// a área restrita do app.
            return const NavBar();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
