import 'package:flutter/material.dart';

class CustomScaffoldMessenger extends StatefulWidget {
  const CustomScaffoldMessenger({super.key, required this.error});

  final String error;

  @override
  State<CustomScaffoldMessenger> createState() =>
      _CustomScaffoldMessengerState();
}

class _CustomScaffoldMessengerState extends State<CustomScaffoldMessenger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnackBar(content: Text("Erro: ${widget.error}")),
    );
  }
}
