import 'package:appbanhang/pages/login.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:appbanhang/widgets/changescreen.dart';
import 'package:appbanhang/widgets/mybutton.dart';
import 'package:appbanhang/widgets/mytextformfield.dart';
import 'package:appbanhang/widgets/passwordTextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final RegExp emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

bool isChecked = false;

class _SignUpState extends State<SignUp> {
  bool obserText = true;
  String email = "";
  String password = "";
  String name = "";
  String sdt = "";
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  validation() async {
    if (formState.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);
        ToastService.showSuccessToast(context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Đăng ký thành công");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ToastService.showWarningToast(
            context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Mật khẩu quá yếu, ít nhất 6 số",
          );
        } else if (e.code == 'email-already-in-use') {
          ToastService.showWarningToast(
            context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Email đã tồn tại!!",
          );
        } else {
          ToastService.showErrorToast(
            context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Đã xảy ra lỗi, vui lòng thử lại.",
          );
        }
      } on PlatformException catch (e) {
        print(e.message.toString());

        ToastService.showErrorToast(
          context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Đã xảy ra lỗi, vui lòng thử lại.",
        );
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Vui lòng kiểm tra lại thông tin nhập liệu.'),
      //   ),
      // );
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
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "Tên",
            onChanged: (value) {
              setState(() {
                name = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng nhập tên, không được bỏ trống";
              } else if (value.length < 3) {
                return "Vui lòng nhập tên, tên bạn quá ngắn";
              }
              return null;
            },
          ),
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
          MyTextFormField(
            name: "SĐT",
            onChanged: (value) {
              setState(() {
                sdt = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng nhập số điện thoại";
              } else if (value.length < 10) {
                return "Số điện thoại phải 10 số";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      height: 500,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAllTextFormField(),
          MyButton(
            name: "Đăng ký",
            onPressed: () {
              validation();
              print(validation);
            },
          ),
          ChangeScreen(
            name: "Đăng nhập",
            whichAccount: "Bạn đã có tài khoản!!",
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => Login()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Đăng ký",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // quay về trang welcome
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formState,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/shop1.jpg',
                    width: 300,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildBottomPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
