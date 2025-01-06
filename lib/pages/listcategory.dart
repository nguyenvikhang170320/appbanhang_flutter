import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/pages/listproductcategory.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({super.key});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getCategoryItem();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh mục",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => BottomNav(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          NotificationButton(),
        ],
      ),
      body: StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    String categorys = ds["Name"];
                    return GestureDetector(
                      onTap: () {
                        //chuyển trang load sản phẩm đúng danh mục
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) =>
                                ListProductCategory(category: categorys)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                    child: Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoolTextFeildStyle(),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
