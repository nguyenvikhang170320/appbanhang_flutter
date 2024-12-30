import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/services/database.dart';
import 'package:appbanhang/widgets/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadProductHortical extends StatefulWidget {
  @override
  State<LoadProductHortical> createState() => _LoadProductHorticalState();
}

class _LoadProductHorticalState extends State<LoadProductHortical> {
  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getProductFeatureItem();
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
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    // lấy dữ liệu từ firebase truyền về
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    //lấy từ firebase truyền về lớp model tạo ra
                    final Products products = Products.fromFirestore(ds);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(product: products)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Container(
                                              child: Text(
                                            ds["Name"],
                                            style: AppWidget
                                                .semiBoolTextFeildStyle(),
                                          )),
                                          Container(
                                              child: Text(
                                            "\$" + ds["Price"].toString(),
                                            style: AppWidget
                                                .semiBoolTextFeildStyle(),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
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
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sản phẩm nổi bật",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => ListProduct()),
                          );
                        },
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                _loadProduct(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
