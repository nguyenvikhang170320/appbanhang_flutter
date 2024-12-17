// import 'package:appbanhang/pages/bottomnav.dart';
// import 'package:appbanhang/pages/home.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/listproduct.dart';
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
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      home: BottomNav(),
    );
  }
}
