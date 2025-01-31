import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/seller/bottomnavseller.dart';
import 'package:appbanhang/pages/signupuser.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:appbanhang/widgets/users/changescreen.dart';
import 'package:appbanhang/widgets/users/mybuttonuser.dart';
import 'package:appbanhang/widgets/users/emailtextformfield.dart';
import 'package:appbanhang/widgets/users/passwordTextformfield.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

import '../services/sharedpreferences/userpreferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final _messangerKey = GlobalKey<ScaffoldMessengerState>();

final RegExp nameRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

bool obserText = true;
String email = "";
String password = "";
bool isChecked = false;

TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();



class _LoginState extends State<Login> {

  void validation() async {
    if (_formkey.currentState!.validate()) {
      try {
        setState(() {
          email = emailController.text;
          password = passwordController.text;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        String userId = userCredential.user!.uid;
        await UserPreferences.setUid(userId);
        print("UserID đã được lưu: $userId");

        // Lấy thông tin người dùng từ Firestore sau khi đăng nhập
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users') // Thay 'users' bằng tên collection của bạn
            .doc(userId)
            .get();

        String role = userData['role'];

        if (role == 'user') {
          print("user");
          //show thông báo dạng toasty
          ToastService.showSuccessToast(context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Đăng nhập thành công");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
        } else if (role == 'seller') {
          print("seller");
          //show thông báo dạng toasty
          ToastService.showSuccessToast(context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Đăng nhập thành công");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNavSeller()));
        } else {
          // Xử lý trường hợp role không hợp lệ hoặc không tồn tại
          ToastService.showErrorToast(context,
              message: "Vai trò không xác định!",
              length: ToastLength.medium,
              expandedHeight: 100);
          FirebaseAuth.instance.signOut(); // Đăng xuất người dùng nếu vai trò không hợp lệ
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ToastService.showWarningToast(context,
              length: ToastLength.medium,
              expandedHeight: 100,
              message: "Không tìm thấy người dùng nào cho email đó");
        } else if (e.code == 'wrong-password') {
          ToastService.showErrorToast(
            context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Sai mật khẩu",
          );
        }
      }
    } else {
      ToastService.showWarningToast(
        context,
        length: ToastLength.medium,
        expandedHeight: 100,
        message: "Vui lòng kiểm tra lại thông tin!! Bạn chưa nhập thông tin",
      );
    }
  }

  //form đăng nhập
  Widget _buildAllTextFormField() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          width: MediaQuery.of(context).size.width,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "Đăng nhập tài khoản",
                  style: AppWidget.HeadlineTextFeildStyle(),
                ),
                SizedBox(
                  height: 20,
                ),
                EmailTextFormField(
                  controllerUser:
                      emailController, //liên quan đến file mytextformfield.dart
                  name: "Nhập email",
                  onChanged: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập email";
                    } else if (!emailRegExp.hasMatch(value)) {
                      return "Vui lòng nhập email hợp lệ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                PasswordTextFormField(
                  passwordController: passwordController,
                  name: "Mật khẩu",
                  obserText: obserText,
                  onChanged: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập mật khẩu";
                    }
                    return null;
                  },
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      obserText = !obserText;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 20,
          ),
          _buildAllTextFormField(),
          SizedBox(
            height: 20,
          ),
          MyButtonUser(
            name: "Đăng nhập",
            onPressed: () {
              validation();
            },
          ),
          ChangeScreen(
            name: "Đăng ký",
            whichAccount: "Bạn chưa có tài khoản?",
            onTap: () {
              isChecked = false;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => SignUp()));
            },
          ),
          ChangeScreen(
            name: "Welcome",
            whichAccount: "Bạn muốn quay về trang trước?",
            onTap: () {
              isChecked = false;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => WelcomePage()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _messangerKey, // dùng message scaffold
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          SafeArea(
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 11, 226, 154),
                            Color.fromARGB(255, 13, 167, 146),
                          ])),
                ),
                Container(
                  child: Form(
                    key: _formkey,
                    child: Container(
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/olx.png",
                              width: MediaQuery.of(context).size.width / 1,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _buildBottomPart(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
