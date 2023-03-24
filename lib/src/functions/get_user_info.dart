// Dependências do Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/src/models/alert_dialogs/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserInfo {
  // Variáveis locais
  final user = FirebaseAuth.instance.currentUser!;
  String userEmail = '';
  String userName = '';
  String userProfilePhoto = '';
  bool isVerified = false;

  /// getUserInfo retorna de forma assíncrona os dados
  /// do usuário, como: nome, email, foto do
  /// perfil e se o mesmo está verificado.
  Future getUserInfo() async {
    try {
      /// docRef instancia a collection 'users'
      /// no documento do mesmo ID do usuário.
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      /// doc gera um DocumentSnapshot com as
      /// informações de docRef, usando o método
      /// get();
      final doc = await docRef.get();

      /// data tranforma os dados da variável doc
      /// de DocumentSnapshot para Map<String, dynamic>
      /// facilitando assim o uso no app.
      final data = doc.data() as Map<String, dynamic>;

      /// esse bloco coloca as informações de data
      /// em suas respectivas variáveis
      /// como exemplificado abaixo
      userName = data['name'];
      userEmail = data['email'];
      userProfilePhoto = data['profilePhoto'];
      isVerified = data['isVerified'];
    }

    /// catch capta erros e retorna em um CustomSnackBar no rodapé da tela.
    catch (e) {
      CustomScaffoldMessenger(text: 'Erro em: $e');
    }
  }
}
