import 'package:appbanhang/model/users.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/onboard.dart';
import 'package:appbanhang/pages/seller/bottomnavseller.dart';
import 'package:appbanhang/provider/cartprovider.dart';
import 'package:appbanhang/provider/orderprovider.dart';
import 'package:appbanhang/provider/productprovider.dart';
import 'package:appbanhang/provider/sellerprovider.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        ChangeNotifierProvider(create: (ctx) => SellerProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user != null) {
              print(user.uid);

              return  StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(), // Lắng nghe thay đổi của document
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    DocumentSnapshot? userData = snapshot.data;
                    if (userData != null && userData.exists) {
                      String role = userData['role']; // Lấy giá trị 'role' từ document
                        if (role == 'user') {
                          print("user");
                          return BottomNav();
                        } else if (role == 'seller') {
                          print("seller");
                          return BottomNavSeller();
                        } else {
                          // Xử lý trường hợp role không hợp lệ hoặc không tồn tại
                          return Center(child: Text('Không có tài kh'));
                        }
                    } else {
                      return Center(child: Text('Không tìm thấy dữ liệu người dùng!'));
                    }
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  }
                },
              );
            } else {
              return Onboard();
            }
          } else {
            return Center(
                child: CircularProgressIndicator()); // Hiển thị loading trong khi chờ trạng thái kết nối
          }
        },
        ),
      ),
    );
  }
}
