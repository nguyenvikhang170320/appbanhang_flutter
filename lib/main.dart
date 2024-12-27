import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAuDFtOd6roJ9BVh_8nG5DvGWWWhIpYhb0',
    appId: '1:233984732592:android:f236edc216b9f9c4447a75',
    messagingSenderId: 'sendid',
    projectId: 'appbanhangflutter',
  )); // kết nối firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapShot) =>
            snapShot.hasData ? BottomNav() : WelcomePage(),
      ),
    );
  }
}
