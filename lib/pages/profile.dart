import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/widgets/profile/mybuttonprofile.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:appbanhang/widgets/users/mybuttonuser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _buildSingleProfile({required String name, required String value}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppWidget.boldTextFeildStyle(),
            ),
            Text(
              value,
              style: AppWidget.boldTextFeildStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({required String name}) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leading: edit == true?  IconButton(icon: Icon(Icons.close, color: Colors.amber, size: 30,),onPressed: () {
          setState(() {
            edit = false;
          });
        },): SizedBox(),
        actions: [
          edit == false ? NotificationButton(): IconButton(onPressed: () {
            
          }, icon: Icon(Icons.check, size: 30, color: Colors.cyanAccent,))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Stack(children: <Widget>[
              Container(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 65,
                      backgroundImage: AssetImage("assets/images/users.jpg"),
                    )
                  ],
                ),
              ),
              edit == true
                  ? Padding(
                      padding: EdgeInsets.only(left: 220, top: 100, right: 2),
                      child: CircleAvatar(
                        child: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      height: 380,
                      child: edit == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                  _buildTextFormField(name: "Khang"),
                                  _buildTextFormField(name: "ken@gmail.com"),
                                  _buildTextFormField(name: "0123456789"),
                                  _buildTextFormField(name: "Nam"),
                                  _buildTextFormField(name: "Chưa xác minh"),
                                ])
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSingleProfile(
                                    name: "Tên:", value: "Tuấn Ken"),
                                _buildSingleProfile(
                                    name: "Email:", value: "tuanken@gmail.com"),
                                _buildSingleProfile(
                                    name: "SĐT:", value: "0123456789"),
                                _buildSingleProfile(
                                    name: "Giới tính:", value: "Nam"),
                                _buildSingleProfile(
                                    name: "Trạng thái tài khoản:",
                                    value: "Chưa xác minh"),
                              ],
                            )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //chỉnh sửa
            edit == false
                ? MyButtonProfile(
                    onPressed: () {
                      setState(() {
                        edit = true;
                      });
                    },
                    name: "Chỉnh sửa hồ sơ",
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            //xác minh tài khoản
            edit == true
                ? MyButtonProfile(
                    onPressed: () {},
                    name: "Xác minh tài khoản",
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            //xoá tài khoản
            edit == true
                ? MyButtonProfile(
                    onPressed: () {},
                    name: "Xóa tài khoản",
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
