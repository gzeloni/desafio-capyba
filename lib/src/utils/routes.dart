import 'package:desafio_capyba/core/check_login/check_login.dart';
import 'package:desafio_capyba/src/navbar/navbar.dart';
import 'package:desafio_capyba/src/screens/home.dart';
import 'package:desafio_capyba/src/screens/login_page.dart';
import 'package:desafio_capyba/src/screens/new_user.dart';
import 'package:desafio_capyba/src/screens/restricted_area.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const LoginPage(),
  '/home': (context) => const HomePage(),
  '/newUser': (context) => const NewUserPage(),
  '/restrict': (context) => const RestrictArea(),
  '/checkLogin': (context) => const CheckLogin(),
  '/navbar': (context) => const NavBar(),
};
