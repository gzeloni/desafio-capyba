import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/src/screens/new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  final user = FirebaseAuth.instance.currentUser;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  var userProfilePhoto = '';

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faça uma Selfie')),
      body: Column(
        children: [
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;

                    final image = await _controller.takePicture();

                    if (userProfilePhoto != '') {
                      FirebaseStorage.instance
                          .ref()
                          .child('users/${user!.uid}/profilePhoto');
                    }

                    final profilephotoRef = FirebaseStorage.instance
                        .ref()
                        .child('users/${user!.uid}/profilePhoto');

                    await profilephotoRef.putFile(File(image.path));
                    profilephotoRef.getDownloadURL().then((value) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .set({
                          'profilePhoto': value,
                        });
                        userProfilePhoto = value;
                      });
                    });

                    if (!mounted) return;

                    await Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const NewUserPage(),
                      ),
                      ModalRoute.withName('/'),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
