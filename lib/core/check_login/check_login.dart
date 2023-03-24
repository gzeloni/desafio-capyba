import 'package:desafio_capyba/src/navbar/navbar.dart';
import 'package:desafio_capyba/src/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavBar();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
