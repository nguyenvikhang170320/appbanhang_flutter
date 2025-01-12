import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/listcategory.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ListProductCategory extends StatefulWidget {
  final String category;
  const ListProductCategory({super.key, required this.category});
  @override
  State<ListProductCategory> createState() => _ListProductCategoryState();
}

class _ListProductCategoryState extends State<ListProductCategory> {
  Stream? fooditemStream;

  ontheload() async {
    fooditemStream =
        await DatabaseMethods().getProductCategoryItem(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget _loadProduct() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    //lấy từ firebase truyền về lớp model tạo ra
                    final Products products = Products.fromFirestore(ds);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  products: products,
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            child: Text(
                                          ds["Name"], //tên
                                          style: AppWidget
                                              .semiBoolTextFeildStyle(),
                                        )),
                                        Container(
                                            child: Text(
                                          ds["Price"].toString(), //giá
                                          style: AppWidget
                                              .semiBoolTextFeildStyle(),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sản phẩm",
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
                builder: (ctx) => ListCategory(),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
      body: _loadProduct(),
    );
  }
}
