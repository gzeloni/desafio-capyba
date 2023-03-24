import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:desafio_capyba/src/models/drawer/custom_drawer.dart';
import 'package:desafio_capyba/src/models/loading_windows/loading_window.dart';
import 'package:desafio_capyba/src/models/post_card/post_card.dart';
import 'package:flutter/material.dart';

class RestrictArea extends StatefulWidget {
  const RestrictArea({super.key});

  @override
  State<RestrictArea> createState() => _RestrictAreaState();
}

class _RestrictAreaState extends State<RestrictArea> {
  GetUserInfo userInfo = GetUserInfo();
  Duration duration = const Duration(seconds: 3);
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
