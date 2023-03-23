import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/main.dart';
import 'package:desafio_capyba/src/models/custom_text_field.dart';
import 'package:desafio_capyba/src/models/loading_window.dart';
import 'package:desafio_capyba/src/screens/camera_screen.dart';
import 'package:desafio_capyba/src/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key, this.imagePath});

  final String? imagePath;

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final user = FirebaseAuth.instance.currentUser;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Duration duration = const Duration(seconds: 3);
  var userProfilePhoto = '';
  String userUID = '';
  String userEmail = '';
  bool _showPassword = true;

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future createUserDB(String name) async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'name': name,
      'email': _emailController.text.trim(),
      'profilePhoto': widget.imagePath!,
    });
    print(user!.uid);
  }

  void uploadImage() async {
    try {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TakePictureScreen(
                camera: firstCamera,
              )));
      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${user!.uid}/profilePhoto');

      await profilephotoRef.putFile(File(widget.imagePath!));
      profilephotoRef.getDownloadURL().then((value) {
        setState(() {
          FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
            'profilePhoto': value,
          });
          userProfilePhoto = value;
        });
      });
    } catch (e) {
      print("Erro em upload: $e");
    }
  }

  void showPassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
    });
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          reverse: true,
          padding:
              const EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 20),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
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
                  //ProfilePhoto Container

                  GestureDetector(
                    onTap: () {
                      uploadImage();
                    },
                    child: widget.imagePath != null
                        ? CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 14, 31),
                            radius: 100,
                            // child: Image.file(File(widget.imagePath.toString())),
                            backgroundImage:
                                FileImage(File(widget.imagePath.toString())),
                          )
                        : const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 1, 14, 31),
                            radius: 100,
                            child: Icon(
                              Iconsax.personalcard,
                              size: 120,
                              color: Color.fromARGB(255, 0, 233, 99),
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
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
                          controller: _passwordController,
                          obscureText: _showPassword,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                showPassword();
                              },
                              child: Icon(
                                _showPassword == true
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
                  ),
                  const SizedBox(height: 20),

                  //Confirm Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
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
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirmar senha',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  //RegisterButton
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
                                        'Sua senha deve conter no mínimo 6 caracteres.'));
                              });
                        } else if (_nameController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty &&
                            widget.imagePath.toString().isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const LoadingWindow();
                              });
                          signUp().whenComplete(() {
                            createUserDB(_nameController.text.trim());
                            uploadImage();
                          }).whenComplete(() => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage())));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 215, 254, 215),
                                title: Text(
                                  "Algo deu errado!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 1, 14, 31),
                                  ),
                                ),
                                content: Text(
                                  "Tenha certeza de que preencheu os campos corretamente e adicionou uma foto de perfil.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 1, 14, 31),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 233, 99),
                          border: Border.all(
                              color: const Color.fromARGB(255, 1, 14, 31)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 14, 31),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ),
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
}
