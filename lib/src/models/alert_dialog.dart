import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 215, 254, 215),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 1, 14, 31),
        ),
      ),
      content: Text(
        widget.content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 1, 14, 31),
        ),
      ),
    );
  }
}
