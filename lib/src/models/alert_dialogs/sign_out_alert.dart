import 'package:desafio_capyba/src/models/loading_windows/loading_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Esse alerta pergunta se o usuário deseja mesmo sair
/// da aplicação e se sim, roda a função de logout
/// do Firebase Auth.
/// se não, roda um Navigator.pop() e continua a
/// execução.
class ConfirmSignOutAlert extends StatefulWidget {
  const ConfirmSignOutAlert({
    super.key,
  });

  @override
  State<ConfirmSignOutAlert> createState() => _ConfirmSignOutAlertState();
}

class _ConfirmSignOutAlertState extends State<ConfirmSignOutAlert> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 215, 254, 215),
          title: const Text(
            'Deseja mesmo sair?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 14, 31),
            ),
          ),
          content: const Text(
            'Você será redirecionado para a tela de login.',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Color.fromARGB(255, 1, 14, 31),
            ),
          ),
          actions: [
            TextButton(
              // Com essa função o usuário não faz logout
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              /// Essa função roda uma tela de loading e em seguida faz o
              /// logout por meio do FirebaseAuth.instance.signOut().
              /// Somente após o signout ocorrer é que o Navigator é
              /// acionado.
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LoadingWindow();
                  },
                );
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false));
              },
              child: const Text('Sair'),
            ),
          ]),
    );
  }
}
