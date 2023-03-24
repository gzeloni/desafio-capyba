import 'package:flutter/material.dart';

/// Imagem que aparece na tela principal e
/// na tela de criação de conta.
class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/logo.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 20),
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'PaytoneOne', fontSize: 30),
          ),
        ),
      ],
    );
  }
}
