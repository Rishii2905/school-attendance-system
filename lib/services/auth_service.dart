import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Admin creates a new user
  Future<void> adminCreateUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    // Create secondary Firebase app so admin stays logged in
    FirebaseApp tempApp = await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: Firebase.app().options,
    );

    FirebaseAuth tempAuth = FirebaseAuth.instanceFor(app: tempApp);

    // Create user in Firebase Auth
    UserCredential userCred = await tempAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCred.user!.uid;

    // Save user in Firestore
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Delete temp app
    await tempApp.delete();
  }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}