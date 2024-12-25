import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/widgets/singlecategory.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({super.key});

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
          margin: EdgeInsets.fromLTRB(10, 10, 5, 5),
          child: Column(
            children: <Widget>[
              Container(
                height: 700,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SingleCategory(name: "Điện thoại", image: "dienthoai.jpg"),
                    SingleCategory(name: "Laptop", image: "laptop.jpg"),
                    SingleCategory(name: "Bánh", image: "sanwick.jpg"),
                    SingleCategory(name: "Kem", image: "kem.jpg"),
                    SingleCategory(name: "Quần áo", image: "clothes.jpg"),
                    SingleCategory(name: "Giày", image: "shoe.jpeg"),
                    SingleCategory(name: "Dép", image: "shoe_dep.jpg"),
                    SingleCategory(name: "Đôi guốc nữ", image: "shoe2.jpg"),
                    SingleCategory(name: "Trái cây", image: "traidau.png"),
                    SingleCategory(name: "Thịt", image: "thit_ga.jpg"),
                    SingleCategory(name: "Cá", image: "fish.jpg"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
