import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserInfo {
  final user = FirebaseAuth.instance.currentUser!;
  String userEmail = '';
  String userName = '';
  String userProfilePhoto = '';
  String userStatus = '';

  Future getUserInfo() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection("users").doc(user.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      userName = data['name'];
      userEmail = data['email'];
      userProfilePhoto = data['profilePhoto'];
    } catch (e) {
      print(e);
    }
  }
}