import 'package:flutter/material.dart';

// Carrega uma animação de loading ¯\_(ツ)_/¯
class CameraLoading extends StatelessWidget {
  const CameraLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
