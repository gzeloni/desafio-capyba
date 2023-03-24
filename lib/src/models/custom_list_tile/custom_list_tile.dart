import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(
      {super.key, required this.title, required this.onTap, this.controller});

  final String title;
  final TextEditingController? controller;
  final void Function()? onTap;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: const Icon(Icons.edit),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 215, 254, 215),
            title: const Text(
              "Editar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 1, 14, 31),
              ),
            ),
            actions: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: widget.title,
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 1, 14, 31),
                  ),
                ),
                controller: widget.controller,
                onEditingComplete: widget.onTap,
                style: const TextStyle(
                  color: Color.fromARGB(255, 1, 14, 31),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
