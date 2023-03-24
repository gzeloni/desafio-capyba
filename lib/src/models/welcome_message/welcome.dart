import 'package:flutter/material.dart';

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
            maxLines: 1,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'PaytoneOne', fontSize: 30),
          ),
        ),
      ],
    );
  }
}
