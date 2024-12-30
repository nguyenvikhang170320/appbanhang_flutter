import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBgENRThwZlXGBqA0JW1f_wNlfrc6RVZok',
    appId: '1:170381222062:android:77574af4745b0942d14d3f',
    messagingSenderId: 'sendid',
    projectId: 'foodappflutter-d99ee',
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
