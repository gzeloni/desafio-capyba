import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/src/functions/check_email.dart';
import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:desafio_capyba/src/models/alert_dialogs/sign_out_alert.dart';
import 'package:desafio_capyba/src/models/drawer/custom_drawer.dart';
import 'package:desafio_capyba/src/models/loading_windows/loading_window.dart';
import 'package:desafio_capyba/src/models/post_card/post_card.dart';
import 'package:desafio_capyba/src/models/welcome_message/welcome.dart';
import 'package:flutter/material.dart';

/// É um clone da tela HomePage mas que só gera itens
/// na tela se isVerified == true
class RestrictArea extends StatefulWidget {
  const RestrictArea({super.key});

  @override
  State<RestrictArea> createState() => _RestrictAreaState();
}

class _RestrictAreaState extends State<RestrictArea> {
  GetUserInfo userInfo = GetUserInfo();
  CheckEmailVerify checkEmailVerify = CheckEmailVerify();
  Duration duration = const Duration(seconds: 10);
  Timer? timer;

  /// Toda vez que o drawer é clicado no
  /// aplicativo, o app consulta as câmeras do smartphone.
  @override
  void initState() {
    timer =
        Timer.periodic(duration, (_) => checkEmailVerify.checkEmailVerified());
    super.initState();
  }

  /// Toda vez que o drawer é fechado, a lista
  /// de câmeras é fechada e o timer (explicado mais abaixo)
  /// são encerrados.
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('restrict').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
            WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 1, 14, 31),
            appBar: AppBar(
              title: const Text('Restrito'),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 1, 14, 31),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConfirmSignOutAlert();
                        },
                      );
                    },
                    child: const Icon(
                      Icons.exit_to_app,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: !snapshot.hasData
                  ? const LoadingWindow()
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (userInfo.isVerified == true)
                              PostCard(
                                titulo: doc['titulo'].toString(),
                                conteudo: doc['conteudo'].toString(),
                                imagem: doc['imagem'].toString(),
                              ),
                            if (userInfo.isVerified == false)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Welcome(
                                      title:
                                          'É necessário verificar o seu email.'),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
            ),
            drawer: const CustomDrawer(),
          ),
        ),
      ),
    );
  }
}
