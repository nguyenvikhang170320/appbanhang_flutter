import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

List<Product> products = [
  Product(name: "Laptop", price: 600.0, image: "laptop.jpg"),
  Product(name: "Điện thoại", price: 300.0, image: "dienthoai.jpg"),
  Product(name: "Dép lê", price: 3.0, image: "shoe_dep.jpg"),
  Product(name: "Giày snecker", price: 10.0, image: "shoe.jpeg"),
  Product(name: "Quần áo", price: 15.0, image: "clothes1.jpg"),
  Product(name: "Giày da", price: 20.0, image: "shoe1.jpg"),
  Product(name: "Đôi ruốc nữ", price: 20.0, image: "shoe2.jpg"),
  Product(name: "Thịt", price: 5.0, image: "thit_ga.jpg"),
];

class LoadProductVertical extends StatefulWidget {
  const LoadProductVertical({super.key});

  @override
  State<LoadProductVertical> createState() => _LoadProductVerticalState();
}

class _LoadProductVerticalState extends State<LoadProductVertical> {
  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getProductMoiItem();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  late Products products;
  Widget _loadProduct() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
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
                                builder: (context) => DetailPage(
                                  products: products,
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          ds["Name"],
                                          style: AppWidget
                                              .semiBoolTextFeildStyle(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        child: Text(
                                          "\$" + ds["Price"].toString(),
                                          style: AppWidget
                                              .semiBoolTextFeildStyle(),
                                        ),
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
            height: 20,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sản phẩm mới",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => ListProduct(),
                            ),
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
