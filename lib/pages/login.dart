import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/signup.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:appbanhang/widgets/changescreen.dart';
import 'package:appbanhang/widgets/mybutton.dart';
import 'package:appbanhang/widgets/mytextformfield.dart';
import 'package:appbanhang/widgets/passwordTextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

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

class _LoginState extends State<Login> {
  void validation() async {
    if (_formkey.currentState!.validate()) {
      try {
        isChecked = false;
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        //show thông báo dạng toasty
        ToastService.showSuccessToast(context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Đăng nhập thành công");
        //chuyển màn hình
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
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

  Widget _buildAllTextFormField() {
    return Container(
      height: 200,
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
      height: 350,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAllTextFormField(),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked,
                  tristate: true,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        isChecked = value;
                        ToastService.showSuccessToast(
                          context,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message: "Cảm ơn bạn đã đồng ý điều khoản",
                        );
                      } else {
                        isChecked = false;
                      }
                    });
                  },
                ),
                Text(
                  "Bắt đầu, đồng ý với điều khoản\n dịch vụ app của chúng tôi",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          //button liên quan mybutton.dart
          MyButton(
            name: "Đăng nhập",
            onPressed: () {
              if (isChecked == false) {
                ToastService.showErrorToast(
                  context,
                  length: ToastLength.medium,
                  expandedHeight: 100,
                  message: "Bạn chưa tích chọn, đồng ý với điều khoản app ạ!!",
                );
              } else {
                validation();
                print(validation);
              }
            },
          ),

          //liên quan đến changescreen
          ChangeScreen(
            name: "Đăng ký",
            whichAccount: "Bạn chưa có tài khoản?",
            onTap: () {
              isChecked = false;
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
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/shop1.jpg',
                  width: 250,
                  height: 250,
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
