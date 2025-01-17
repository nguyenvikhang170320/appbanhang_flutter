import 'dart:io';
import 'package:appbanhang/services/database/databasemethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController namecontroller = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  //chọn option : camera hay thư viện ảnh
  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Chọn từ thư viện'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Chụp ảnh'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //xét dữ liệu
  Future getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        ToastService.showWarningToast(context,
            length: ToastLength.medium,
            expandedHeight: 100,
            message: "Không có hình ẩnh");
      }
    });
  }

  //upload lên cơ sở dữ liệu
  uploadItem() async {
    if (selectedImage != null && namecontroller.text != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("imageDanhmuc").child(addId);
      final UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await uploadTask).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": namecontroller.text,
      };

      await DatabaseMethods().categoryDetail(addItem);

      ToastService.showSuccessToast(context,
          length: ToastLength.medium,
          expandedHeight: 100,
          message: "Thêm danh mục thành công");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF373866),
            )),
        centerTitle: true,
        title: Text(
          "Thêm danh mục",
          style: AppWidget.HeadlineTextFeildStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tải lên hình ảnh sản phẩm",
                style: AppWidget.semiBoolTextFeildStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        showImagePickerOptions(); //chọn camera hay thư viện ảnh
                      },
                      child: Center(
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Tên danh mục",
                style: AppWidget.semiBoolTextFeildStyle(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tên danh mục",
                      hintStyle: AppWidget.LightTextFeildStyle()),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Thêm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
