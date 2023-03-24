import 'package:flutter/material.dart';

class CustomScaffoldMessenger extends StatefulWidget {
  const CustomScaffoldMessenger({super.key, required this.text});

  final String text;
  @override
  State<CustomScaffoldMessenger> createState() =>
      _CustomScaffoldMessengerState();
}

class _CustomScaffoldMessengerState extends State<CustomScaffoldMessenger> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(widget.text));
  }
}
