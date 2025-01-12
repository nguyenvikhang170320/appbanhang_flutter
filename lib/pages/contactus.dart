import 'package:appbanhang/model/users.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:appbanhang/widgets/profile/mybuttonprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController message = TextEditingController();

  late String name;
  late String email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void vaildation() async {
    if (message.text.isEmpty) {
      ToastService.showErrorToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Bạn chưa nhập thông tin muốn gửi đến chúng tôi?");
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("message").doc(user?.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
      ToastService.showSuccessToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Bạn check email của bạn, và đợi phản hồi của chúng tôi nhá, xin chân thành cảm ơn. Thân mến!!");
    }
  }

  Widget _buildSingleFlied({required String name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    UserProvider provider;
    provider = Provider.of<UserProvider>(context, listen: false);
    List<Users> user = provider.userModelList;
    user.map((e) {
      name = e.name;
      email = e.email;

      return Container();
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(name);

    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Liên hệ chúng tôi",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => BottomNav(),
                ),
              );
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 27),
          height: 600,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text(
                "Gửi cho chúng tôi tin nhắn của bạn",
                style: TextStyle(
                  color: Color(0xff746bc9),
                  fontSize: 24,
                ),
              ),
              _buildSingleFlied(name: name),
              _buildSingleFlied(name: email),
              Container(
                height: 200,
                child: TextFormField(
                  controller: message,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: " Message",
                  ),
                ),
              ),
              MyButtonProfile(
                name: "Submit",
                onPressed: () {
                  vaildation();
                },
              )
            ],
          ),
        ),
      );
  }
}
