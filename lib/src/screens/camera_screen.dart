import 'dart:io';
import 'package:desafio_capyba/core/globals/globals.dart';
import 'package:desafio_capyba/src/models/loading_windows/camera_loading_window.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:desafio_capyba/src/navbar/navbar.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.user,
  });

  /// Essas variáveis são preenchidas com informações
  /// da tela anterior (NewUserPage).
  final CameraDescription camera;
  final User user;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // Controllers que serão iniciados depois.
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  // Variável de arquivo.
  XFile? pickedFile;

  // Inicia os Controllers e define a qualidade da câmera
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  // Destrói o processo do controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// O usuário só consegue sair dessa tela se
    /// Encerrar o app.
    /// É obrigatório que o mesmo faça a selfie.
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Faça uma Selfie'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 1, 14, 31),
        ),
        body: Column(
          children: [
            /// Constrói a tela com um CameraPreview
            /// que tem future um dos controllers.
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),

        // Botão para tirar a foto
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 1, 14, 31),

                /// Roda o controller da câmera e tira uma foto
                /// que é então enviada para o firebase
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    uploadImage();
                  } catch (e) {
                    final SnackBar snackBar = SnackBar(
                      content: Text("Erro: $e"),
                      duration: const Duration(seconds: 3),
                    );
                    snackbarKey.currentState?.showSnackBar(snackBar);
                  }
                },
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Color.fromARGB(255, 0, 233, 99),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Método uploadImage abre uma câmera frontal customizada.
  /// Sendo possível apenas tirar a foto pela câmera frontal.
  /// Que é então salva na path do dispositivo.
  /// E depois é executado o upload para o Firebase Storage.
  /// Que devolve o link da foto para a variável userProfilePhoto.
  void uploadImage() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const CameraLoading();
        },
      );
      // Roda o módulo de câmera por uma função assíncrona
      pickedFile = await _controller.takePicture();

      // Cria um caminho para a foto que foi tirada no Firebase Storage
      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${widget.user.uid}/profilePhoto');

      // Aguarda o upload da foto para o Firebase Storage
      await profilephotoRef.putFile(File(pickedFile!.path));
      // Pega o link da foto recém upada e ENTÃO:
      profilephotoRef.getDownloadURL().then((value) {
        // Atualiza o campo profilePhoto no doc do usuário no Firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.uid)
            .update({
          'profilePhoto': value,
        });
        // Quando completar o passo anterior:
      }).whenComplete(() {
        // Navega para a Home Page destruindo a rota anterior.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ),
          ModalRoute.withName('/'),
        );
      });
      // Se houver falha no upload:
    } catch (e) {
      final SnackBar snackBar = SnackBar(
        content: Text("Erro: $e"),
        duration: const Duration(seconds: 3),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
