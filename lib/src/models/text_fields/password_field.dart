import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.passwordController,
    required this.onTap,
    required this.showPassword,
  });

  final TextEditingController passwordController;
  final bool showPassword;
  final void Function()? onTap;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 1, 14, 31),
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: widget.passwordController,
                obscureText: widget.showPassword,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      widget.onTap;
                    },
                    child: Icon(
                      widget.showPassword == true
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                      color: Colors.white,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Senha',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
