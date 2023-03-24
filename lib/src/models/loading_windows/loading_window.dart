import 'package:flutter/material.dart';

class LoadingWindow extends StatelessWidget {
  const LoadingWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 215, 254, 215),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 5),
              Text(
                "Carregando",
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 14, 31),
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
