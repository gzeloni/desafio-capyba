import 'package:flutter/material.dart';

/// É um botão de login :)
/// Só não o queria na tela principal, estava feio.
/// Ele recebe o título por parâmetro.
class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key, required this.title});

  final String title;

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 233, 99),
        border: Border.all(color: const Color.fromARGB(255, 1, 14, 31)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
              color: Color.fromARGB(255, 1, 14, 31),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
    );
  }
}
