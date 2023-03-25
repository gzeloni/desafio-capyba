import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/core/camera/get_camera_list.dart';
import 'package:desafio_capyba/core/globals/global_key.dart';
import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:desafio_capyba/src/models/custom_list_tile/custom_list_tile.dart';
import 'package:desafio_capyba/src/screens/camera_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// CustomDrawer é utilizado nas telas:
/// HomePage e RestrictPage.
/// Alterar em uma tela altera em outra e
/// nenhum parâmetro é externo, ou seja,
/// CUIDADO COM O QUE EDITA AQUI
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isEmailVerified = false;
  GetUserInfo userInfo = GetUserInfo();
  // Classe que retorna uma lista de câmeras
  GetCameraList getCameraList = GetCameraList();
  // Variável de credencial (iniciam nulas)

  /// Toda vez que o drawer é clicado no
  /// aplicativo, o app consulta as câmeras do smartphone.
  @override
  void initState() {
    getCameraList.getCameraList();
    super.initState();
  }

  /// Toda vez que o drawer é fechado, a lista
  /// de câmeras é fechada e o timer (explicado mais abaixo)
  /// são encerrados.
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('home').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => SafeArea(
          child: Drawer(
            backgroundColor: const Color.fromARGB(255, 1, 14, 31),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                /// Tocar na foto abre a câmera, sendo possível
                /// cancelar a operação sem receber erros.
                GestureDetector(
                  onTap: () {
                    try {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakePictureScreen(
                                camera: getCameraList.firstCamera,
                                user: userInfo.user,
                              )));
                    } catch (e) {
                      const SnackBar snackBar = SnackBar(
                        content: Text("Encontramos um erro :("),
                        duration: Duration(seconds: 3),
                      );
                      snackbarKey.currentState?.showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 375,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        /// AVISO DE GAMBIARRA
                        /// Esse widget tem duas opções de tela pois
                        /// ao abrir o drawer, o builder fica nulo
                        /// por uns milissegundos.
                        /// Nada perceptível ao usuário, mas sem essa função vai quebrar.
                        image: NetworkImage(userInfo.userProfilePhoto != ''
                            ? userInfo.userProfilePhoto
                            : 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 45,
                    ),
                  ),
                ),

                /// O CustomListTile espera por um
                /// título e uma função void.
                /// Dentro da função void é chamado um
                /// setState(() {}); que atualiza o nome ao
                /// mesmo tempo que roda a função updateUserDB
                /// que espera por uma String e um controller.
                CustomListTile(
                    title: userInfo.userName,
                    onTap: () {
                      setState(() {
                        updateUserDB('name', _nameController);
                        Navigator.pop(context);
                      });
                    },
                    controller: _nameController),
                CustomListTile(
                    title: userInfo.userEmail,
                    onTap: () {
                      setState(() {
                        updateUserDB('email', _emailController);
                        Navigator.pop(context);
                      });
                    },
                    controller: _emailController),
                const SizedBox(
                  height: 40,
                ),

                /// (Esse botão inicia o timer que comentei lá no começo)
                /// Ao clicar nele, é chamada a função checkEmailVerified()
                /// que a cada 3 segundos verifica se o email foi verificado
                /// ou não.
                TextButton(
                  child: const Text(
                    'Verificar Email',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      verifyEmail();
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Usa os parâmetros solicitados para atualizar um item do Firebase Firestore
  Future updateUserDB(String field, TextEditingController controller) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userInfo.user.uid)
          .update({
        field: controller.text.trim(),
      });
    } catch (e) {
      const SnackBar snackBar = SnackBar(
        content: Text("Encontramos um erro :("),
        duration: Duration(seconds: 3),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }

  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      const SnackBar snackBar = SnackBar(
        content: Text("Encontramos um erro :("),
        duration: Duration(seconds: 3),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
