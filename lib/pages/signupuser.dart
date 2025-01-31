import 'package:appbanhang/pages/login.dart';
import 'package:appbanhang/pages/signupseller.dart';
import 'package:appbanhang/services/database/databasemethod.dart';
import 'package:appbanhang/widgets/users/addresstextformfield.dart';
import 'package:appbanhang/widgets/users/changescreen.dart';
import 'package:appbanhang/widgets/users/mybuttonuser.dart';
import 'package:appbanhang/widgets/users/emailtextformfield.dart';
import 'package:appbanhang/widgets/users/nametextformfield.dart';
import 'package:appbanhang/widgets/users/passwordTextformfield.dart';
import 'package:appbanhang/widgets/users/phonetextformfield.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
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
  String address = "";
  bool isMale = true;
  String image = "";
  String shopname = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  validation() async {
    if (formState.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;
        String uid = user!.uid;

        String IdUser = uid;
        Map<String, dynamic> addUserInfo = {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "shopname": shopname,
          "isMale": isMale == true ? "Nam" : "Nữ",
          "accountstatus": "chưa xác minh",
          "address": addressController.text,
          "uid": IdUser,
          "image": image,
          "role": "user",
        };
        print(addUserInfo);
        // Lưu uid vào Cloud Firestore
        await DatabaseMethods().addUserDetail(addUserInfo, IdUser);

        print(IdUser);

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
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 560,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NameTextFormField(
              controllerUser:
                  nameController, //liên quan đến file mytextformfield.dart
              name: "Nhập tên hoặc họ và tên",
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
            PhoneTextFormField(
              controllerUser:
                  phoneController, //liên quan đến file mytextformfield.dart
              name: "Nhập SĐT",
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
            AddressTextFormField(
              controllerUser:
                  addressController, //liên quan đến file mytextformfield.dart
              name: "Nhập địa chỉ",
              onChanged: (value) {
                setState(() {
                  address = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Vui lòng nhập địa chỉ huyện/tỉnh";
                } else if (value.length > 25) {
                  return "Địa chỉ quá dài";
                }
                return null;
              },
            ),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Text(
                    "Giới tính",
                    style: AppWidget.semiBoolTextFeildStyle(),
                  ),
                  DropdownButton<bool>(
                    value: isMale,
                    onChanged: (value) {
                      setState(() {
                        isMale = value!;
                      });
                      // Cập nhật mức giảm giá cho CartProvider
                    },
                    items: [
                      DropdownMenuItem(value: true, child: Text('Nam')),
                      DropdownMenuItem(value: false, child: Text('Nữ')),
                    ],
                  ),
                ])),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      child: Column(
        children: [
          Text(
            "Đăng ký tài khoản",
            style: AppWidget.HeadlineTextFeildStyle(),
          ),
          SizedBox(
            height: 10,
          ),
          _buildAllTextFormField(),
          SizedBox(
            height: 20,
          ),
          MyButtonUser(
            name: "Đăng ký",
            onPressed: () {
              validation();
              print(validation);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ChangeScreen(
            name: "Đăng nhập",
            whichAccount: "Bạn đã có tài khoản!!",
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => Login()));
            },
          ),
          ChangeScreen(
            name: "Đăng ký",
            whichAccount: "Bạn là người bán!!",
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => SignUpSeller()));
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
      body: ListView(
        children: <Widget>[
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
                        Color.fromARGB(255, 226, 58, 11),
                        Color.fromARGB(255, 231, 109, 75),
                      ])),
                ),
                Container(
                  child: Form(
                    key: formState,
                    child: Container(
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: MediaQuery.of(context).size.width / 1.5,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
      ),
    );
  }
}
