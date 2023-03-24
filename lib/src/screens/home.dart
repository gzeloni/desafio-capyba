import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:desafio_capyba/src/models/loading_window.dart';
import 'package:desafio_capyba/src/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: SafeArea(
          child: Column(
            children: [
              userInfo.userProfilePhoto == ''
                  ? const LoadingWindow()
                  : userInfo.userProfilePhoto != ''
                      ? CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 1, 14, 31),
                          radius: 100,
                          backgroundImage:
                              NetworkImage(userInfo.userProfilePhoto))
                      : const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 1, 14, 31),
                          radius: 100,
                          child: Icon(
                            Iconsax.personalcard,
                            size: 120,
                            color: Color.fromARGB(255, 0, 233, 99),
                          ),
                        ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.escalator,
                      size: 20,
                      color: Color.fromARGB(255, 51, 0, 67),
                      fill: 1,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Sair',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // Expanded(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     // mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       FittedBox(
        //         fit: BoxFit.contain,
        //         child: Text(
        //           maxLines: 1,
        //           textAlign: TextAlign.start,
        //           overflow: TextOverflow.ellipsis,
        //           userInfo.userName,
        //           style: const TextStyle(
        //             color: Color.fromARGB(255, 51, 0, 67),
        //             fontFamily: "PaytoneOne",
        //             fontSize: 20,
        //             //fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //       FittedBox(
        //         fit: BoxFit.contain,
        //         child: Text(
        //           maxLines: 1,
        //           textAlign: TextAlign.start,
        //           overflow: TextOverflow.ellipsis,
        //           userInfo.userEmail,
        //           style: const TextStyle(
        //             color: Color.fromARGB(255, 51, 0, 67),
        //             fontFamily: "Poppins",
        //             fontSize: 16,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 8),
        //       Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           TextButton(
        //               onPressed: () async {
        //                 await FirebaseAuth.instance
        //                     .signOut()
        //                     .whenComplete(() => Navigator.of(
        //                             context)
        //                         .pushAndRemoveUntil(
        //                             MaterialPageRoute(
        //                                 builder: (context) =>
        //                                     const LoginPage()),
        //                             (route) => false));
        //               },
        //               child: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: const [
        //                   Icon(
        //                     Icons.escalator,
        //                     size: 20,
        //                     color: Color.fromARGB(
        //                         255, 51, 0, 67),
        //                     fill: 1,
        //                   ),
        //                   SizedBox(width: 6),
        //                   Text(
        //                     'Sair',
        //                     style: TextStyle(
        //                         color: Color.fromARGB(
        //                             255, 51, 0, 67),
        //                         fontFamily: "Poppins",
        //                         fontSize: 14,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                 ],
        //               )),
        //           const SizedBox(width: 10),
        //           TextButton(
        //             onPressed: () {},
        //             child: Row(
        //               mainAxisSize: MainAxisSize.min,
        //               children: const [
        //                 Icon(
        //                   Iconsax.refresh,
        //                   size: 20,
        //                   color:
        //                       Color.fromARGB(255, 51, 0, 67),
        //                   fill: 1,
        //                 ),
        //                 SizedBox(width: 6),
        //                 Text(
        //                   'Alterar senha',
        //                   style: TextStyle(
        //                       color: Color.fromARGB(
        //                           255, 51, 0, 67),
        //                       fontFamily: "Poppins",
        //                       fontSize: 14,
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        floatingActionButton: userInfo.userStatus == 'Admin'
            ? FloatingActionButton(
                tooltip: 'Lista de usuários',
                elevation: 2,
                onPressed: () {},
                child: const Icon(
                  Icons.person,
                  size: 26,
                ),
              )
            : null,
      ),
    );
  }
}
