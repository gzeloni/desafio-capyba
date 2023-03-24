import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:desafio_capyba/src/models/custom_list_tile/custom_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isEmailVerified = false;
  Timer? timer;
  GetUserInfo userInfo = GetUserInfo();

  @override
  void initState() {
    super.initState();
  }

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
        stream: FirebaseFirestore.instance.collection('home').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => SafeArea(
          child: Drawer(
            backgroundColor: const Color.fromARGB(255, 1, 14, 31),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: 200,
                  height: 375,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(userInfo.userProfilePhoto != ''
                          ? userInfo.userProfilePhoto
                          : 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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

  Future updateUserDB(String field, TextEditingController controller) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userInfo.user.uid)
        .update({
      field: controller.text.trim(),
    });
  }

  Future verifyEmail() async {
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    if (mounted) {
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }
    if (isEmailVerified) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userInfo.user.uid)
          .update({
        'isVerified': true,
      });
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Email Verificado!")));
      }
      timer?.cancel();
    }
  }
}
