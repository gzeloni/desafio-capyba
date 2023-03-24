import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserInfo {
  final user = FirebaseAuth.instance.currentUser!;
  String userEmail = '';
  String userName = '';
  String userProfilePhoto = '';
  bool isVerified = false;

  Future getUserInfo() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      userName = data['name'];
      userEmail = data['email'];
      userProfilePhoto = data['profilePhoto'];
      isVerified = data['isVerified'];
    } catch (e) {
      // TODO mostra um scaffoldMessenger para o usuário no rodapé da página.
      print(e);
    }
  }
}
