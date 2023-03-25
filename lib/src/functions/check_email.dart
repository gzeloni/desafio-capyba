import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/core/globals/global_key.dart';
import 'package:desafio_capyba/src/functions/get_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckEmailVerify {
  bool isEmailVerified = false;
  Timer? timer;
  GetUserInfo userInfo = GetUserInfo();

  /// Ao ser chamado, recarrega as informações do
  /// currentUser (usuário atual) e
  /// SE estiver montado, atualiza com o setState
  /// o booleano isEmailVerified
  checkEmailVerified() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

      /// SE isEmailVerified for true
      if (isEmailVerified) {
        /// atualiza o booleano no doc do usuário
        /// dando autorização para ver a tela RestrictedArea
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userInfo.user.uid)
            .update({
          'isVerified': true,
        });

        /// Para o timer
        timer?.cancel();
      }
    } catch (e) {
      const SnackBar snackBar = SnackBar(
        content: Text("Encontramos um erro :("),
        duration: Duration(seconds: 3),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
