// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddUserInfo {
  // Declaração de variáveis passadas por parâmetro
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final User? user;
  AddUserInfo({
    this.emailController,
    this.passwordController,
    this.user,
  });

  // Declaração de variáveis da classe
  String userProfilePhoto = '';
  String userUID = '';
  String userEmail = '';
  File? imageFile;

  // Método sign-up cria um usuário
  // Recebe o email e a senha e cria um usuário
  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController!.text.trim(),
        password: passwordController!.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Método createUserDB cria um documento na collection
  // users com o uid do usuário criado
  // Contém nome, email e link da foto de perfil
  Future createUserDB(String name) async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'name': name,
      'email': emailController!.text.trim(),
      'profilePhoto': imageFile,
    });
    print(user!.uid);
  }

  // Método uploadImage abre a câmera do dispositivo e tira uma foto
  // que é então salva na path do dispositivo
  // e depois é executado o upload para o Firebase Storage
  // Devolve o link da foto para a variável userProfilePhoto
  void uploadImage() async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(
            source: ImageSource.camera,
            maxWidth: 1800,
            maxHeight: 1800,
          )
          .whenComplete(() => null);
      if (pickedFile != null && userProfilePhoto != '') {
        FirebaseStorage.instance.ref().child('users/${user!.uid}/profilePhoto');
        imageFile = File(pickedFile.path);
      }

      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${user!.uid}/profilePhoto');

      await profilephotoRef.putFile(File(pickedFile!.path));
      profilephotoRef.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({'profilePhoto': value});
        userProfilePhoto = value;
      });
    } catch (e) {
      print("Erro em upload: $e");
    }
  }
}
