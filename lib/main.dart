import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:appbanhang/provider/cartprovider.dart';
import 'package:appbanhang/provider/orderprovider.dart';
import 'package:appbanhang/provider/productprovider.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyBgENRThwZlXGBqA0JW1f_wNlfrc6RVZok',
    appId: '1:170381222062:android:77574af4745b0942d14d3f',
    messagingSenderId: 'sendid',
    projectId: 'foodappflutter-d99ee',
  )); // kết nối firebase
  await FirebaseAppCheck.instance.activate(); //bảo mật firebase app_check
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) =>
              snapShot.hasData ? BottomNav() : WelcomePage(),
        ),
      ),
    );
  }
}
