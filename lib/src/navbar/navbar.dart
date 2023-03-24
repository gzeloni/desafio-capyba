import 'package:desafio_capyba/src/screens/home.dart';
import 'package:desafio_capyba/src/screens/restricted_area.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int indexOf = 0;
  final telas = const [HomePage(), RestrictArea()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas[indexOf],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        selectedFontSize: 15,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 1, 14, 31),
        unselectedItemColor: const Color.fromARGB(255, 215, 254, 215),
        selectedItemColor: const Color.fromARGB(255, 15, 158, 63),
        currentIndex: indexOf,
        onTap: (index) => setState(() => indexOf = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.error),
            label: 'Restrito',
          ),
        ],
      ),
    );
  }
}
