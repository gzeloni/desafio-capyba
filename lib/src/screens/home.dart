import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:desafio_capyba/src/models/drawer/custom_drawer.dart';
import 'package:desafio_capyba/src/models/loading_windows/loading_window.dart';
import 'package:desafio_capyba/src/models/post_card/post_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetUserInfo userInfo = GetUserInfo();
  Duration duration = const Duration(seconds: 3);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('home').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
            WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 1, 14, 31),
            appBar: AppBar(
              title: const Text('Home'),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 1, 14, 31),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GestureDetector(
                    onTap: () {},
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
                            PostCard(
                              titulo: doc['titulo'].toString(),
                              conteudo: doc['conteudo'].toString(),
                              imagem: doc['imagem'].toString(),
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
