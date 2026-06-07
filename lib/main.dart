import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'firebase_options.dart';
import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  if (kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false, // Turn off for a clean test
    );
  } else {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance System',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFFB71C1C),
        primarySwatch: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red[900],
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
