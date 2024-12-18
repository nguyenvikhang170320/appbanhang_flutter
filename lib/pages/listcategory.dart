import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/widgets/singlecategory.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatelessWidget {
  final String name;
  const ListCategory({super.key, required this.name});

  //UI load sản phẩm
  Widget _buildFeatureProduct(String name, double price, String image) {
    return Card(
      child: Container(
        height: 220,
        width: 150,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/images/$image")),
              ),
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  //UI tìm kiếm - nỗi bật - xem tất cả
  Widget _buildHeader() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                builder: (ctx) => HomePages(),
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          _buildHeader(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 690,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SingleCategory(name: "Điện thoại", image: "dienthoai.jpg"),
                SingleCategory(name: "Laptop", image: "laptop.jpg"),
                SingleCategory(name: "Quần áo", image: "clothes.jpg"),
                SingleCategory(name: "Giày", image: "shoe.jpeg"),
                SingleCategory(name: "Dép", image: "shoe_dep.jpg"),
                SingleCategory(name: "Đồ ăn", image: "doan.jpg"),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
