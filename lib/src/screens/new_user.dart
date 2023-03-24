// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/core/camera/get_camera_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:desafio_capyba/src/models/confirm_password_field.dart';
import 'package:desafio_capyba/src/models/custom_text_field.dart';
import 'package:desafio_capyba/src/models/loading_window.dart';
import 'package:desafio_capyba/src/models/password_field.dart';
import 'package:desafio_capyba/src/models/show_dialog.dart';
import 'package:desafio_capyba/src/models/button.dart';
import 'package:desafio_capyba/src/screens/camera_screen.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  GetCameraList getCameraList = GetCameraList();
  UserCredential? result;
  User? user;
  String userProfilePhoto = '';
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    getCameraList.getCameraList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signUp(),
      builder: (context, snapshot) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 14, 31),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Criar Conta',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PaytoneOne',
                          //fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomTextField(
                    expanded: false,
                    keyboardType: TextInputType.name,
                    useController: true,
                    enabled: true,
                    controller: _nameController,
                    hintText: 'Nome',
                  ),
                  CustomTextField(
                    expanded: false,
                    keyboardType: TextInputType.emailAddress,
                    useController: true,
                    enabled: true,
                    controller: _emailController,
                    hintText: "Email",
                  ),
                  PasswordField(
                    passwordController: _passwordController,
                    showPassword: _showPassword,
                    onTap: () {
                      setState(() {
                        showPassword();
                      });
                    },
                  ),
                  ConfirmPasswordField(controller: _confirmPasswordController),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: GestureDetector(
                      onTap: () {
                        if (_passwordController.text.length < 6) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text('Ops...'),
                                content: Text(
                                  'Sua senha deve conter no mínimo 6 caracteres.',
                                ),
                              );
                            },
                          );
                        } else if (_nameController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const LoadingWindow();
                              });
                          signUp().whenComplete(() {
                            createUserDB();
                          }).whenComplete(() => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TakePictureScreen(
                                          camera: getCameraList.firstCamera,
                                          user: user!,
                                          result: result!,
                                        )))
                              });
                        } else {
                          showAlertDialog(context);
                        }
                      },
                      child: const Cadastrar(title: 'Cadastrar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método sign-up cria um usuário
  // Recebe o email e a senha e cria um usuário
  Future signUp() async {
    try {
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      user = result!.user;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Método createUserDB cria um documento na collection
  // users com o uid do usuário criado
  // Contém nome, email e link da foto de perfil
  Future createUserDB() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
    });
  }

  void showPassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
    });
  }
}