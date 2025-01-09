import 'dart:io';

import 'package:appbanhang/model/users.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/provider/cartprovider.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:appbanhang/services/sharedpreferences/userpreferences.dart';
import 'package:appbanhang/widgets/profile/mybuttonprofile.dart';
import 'package:appbanhang/widgets/profile/mytextformfield.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:appbanhang/widgets/users/mybuttonuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController phoneNumber;
  late TextEditingController address;
  late TextEditingController userName;
  bool isMale = false;

  void vaildation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      ToastService.showToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Trường không được bỏ trống");
    } else if (userName.text.isEmpty) {
      ToastService.showToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Vui lòng nhập tên mới");
    } else if (userName.text.length < 3) {
      ToastService.showWarningToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Tên quá ngắn");
    } else if (phoneNumber.text.length < 10 || phoneNumber.text.length > 10) {
      ToastService.showToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Vui lòng nhập SĐT mới");
    } else {

      uploadUserDetail();
    }
  }
  String? image;
  void uploadUserDetail() async {
    final uid = await UserPreferences.getUid();
    // Kiểm tra UID
    if (uid == null) {
      // Hiển thị thông báo lỗi: UID không hợp lệ
      ToastService.showErrorToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Thất bại, không có uid");
      return;
    }

    // Cập nhật dữ liệu
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({
        'name': userName.text,
        'isMale': isMale ? 'Nam' : 'Nữ',
        'phone': phoneNumber.text,
        'image': imageUrl,
        'address': address.text,
      });

      // Cập nhật thành công
      ToastService.showSuccessToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Cập nhật thành công");
    } catch (e) {
      // Xử lý lỗi
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cập nhật dữ liệu thất bại')),
      );
    }
  }
  Widget _buildContainerPart() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    address = TextEditingController(text: userProvider.getAddressData());
    userName = TextEditingController(text: userProvider.getNameData());
    phoneNumber = TextEditingController(text: userProvider.getPhoneData());
    if (userProvider.getIsMaleData() == "Nam") {
      isMale = true;
    } else {
      isMale = false;
    }
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSingleProfile(
                  name: "Tên", value: userProvider.getNameData()),
              _buildSingleProfile(
                  name: "Email", value: userProvider.getEmailData()),
              _buildSingleProfile(
                  name: "SĐT", value: userProvider.getPhoneData()),
              _buildSingleProfile(
                  name: "Giới tính", value: userProvider.getIsMaleData()),
              _buildSingleProfile(
                  name: "Địa chỉ", value: userProvider.getAddressData()),
              _buildSingleProfile(
                  name: "Trạng thái tài khoản",
                  value: userProvider.getAccountStatusData()),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextFormPart() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              MyTextFormField(name: "Tên", controllerUser: userName),
              SizedBox(
                height: 5,
              ),
              _buildTextFormField(name: userProvider.getEmailData()),
              SizedBox(
                height: 5,
              ),
              MyTextFormField(name: "SĐT", controllerUser: phoneNumber),
              SizedBox(
                height: 5,
              ),
              _buildTextFormField(name: userProvider.getIsMaleData()),
              SizedBox(
                height: 5,
              ),
              MyTextFormField(name: "Địa chỉ", controllerUser: address),
              SizedBox(
                height: 5,
              ),
              _buildTextFormField(name: userProvider.getAccountStatusData()),
            ],
          ),
        ],
      ),
    );
  }

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
  //hình ảnh
  // ImagePicker _pickerImage = ImagePicker();
  //hình ảnh
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  Future<void> getImage({required ImageSource imageSource}) async {
    var image = await _picker.pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
      });
    }
  }

  //tùy chọn camera hay thư viện ảnh
  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Chụp ảnh"),
                    onTap: () {
                      getImage(imageSource: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Chọn hình ảnh từ thư viện"),
                    onTap: () {
                      getImage(imageSource: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //upload lên firebase storage
  String? imageUrl;
  void uploadImage({required File image}) async {
    final uid = await UserPreferences.getUid();
    print(uid);
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("ImageUserProfile/${uid}");
    final UploadTask uploadTask = firebaseStorageRef.putFile(image);

    imageUrl = await (await uploadTask).ref.getDownloadURL();
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.amber,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => BottomNav(),
                      ),
                    );
                  });
                },
              ),
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
                  onPressed: () {
                    vaildation();
                    setState(() {
                      edit = false;
                    });
                  },
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.cyanAccent,
                  ))
        ],
      ),
      body: Container(
        height: 720,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
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
                      backgroundImage: selectedImage == null
                          ? AssetImage("assets/images/users.jpg")
                          : FileImage(selectedImage!) as ImageProvider,
                    )
                  ],
                ),
              ),
              edit == true
                  ? Padding(
                      padding: EdgeInsets.only(left: 220, top: 100, right: 2),
                      child: GestureDetector(
                        onTap: () {
                          myDialogBox(context);
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
            Container(
              height: 440,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: edit == true
                        ? _buildTextFormPart()
                        : _buildContainerPart(),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
              height: 10,
            ),
            //xác minh tài khoản
            edit == true
                ? MyButtonProfile(
                    onPressed: () {},
                    name: "Xác minh tài khoản",
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
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
