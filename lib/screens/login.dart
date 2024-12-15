import 'package:appbanhang/screens/bottomnav.dart';
import 'package:appbanhang/screens/signup.dart';
import 'package:appbanhang/widgets/changescreen.dart';
import 'package:appbanhang/widgets/mybutton.dart';
import 'package:appbanhang/widgets/mytextformfield.dart';
import 'package:appbanhang/widgets/passwordTextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

class _LoginState extends State<Login> {
  void validation() async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          content: Text("Đăng nhập thành công!",
              style: TextStyle(fontSize: 20.0, color: Colors.yellow)),
        )));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => BottomNav()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Không tìm thấy người dùng nào cho email đó",
            style: TextStyle(fontSize: 18.0, color: Colors.red),
          )));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Sai mật khẩu",
            style: TextStyle(fontSize: 18.0, color: Colors.red),
          )));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng kiểm tra lại thông tin.'),
        ),
      );
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "Email",
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
          PasswordTextFormField(
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
              } else if (value == "wrong-password") {
                return "Mật khẩu sai";
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
    );
  }

  Widget _newBottom() {
    return Container(
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAllTextFormField(),
          //button liên quan mybutton.dart
          MyButton(
              name: "Đăng nhập",
              onPressed: () {
                validation();
              }),
          //liên quan đến changescreen
          ChangeScreen(
            name: "Đăng ký",
            whichAccount: "Bạn chưa có tài khoản?",
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const SignUp()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _messangerKey,
      resizeToAvoidBottomInset: false,
      // ignore: avoid_unnecessary_containers
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 5, right: 5),
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đăng nhập",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/shop.jpg',
                  width: 300,
                  height: 300,
                ),
                //liên quan mytextformfield.dart
                _newBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
