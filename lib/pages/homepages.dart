import 'package:appbanhang/pages/listcategory.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/widgets/carouselview.dart';
import 'package:appbanhang/widgets/loadproducthortical.dart';
import 'package:appbanhang/widgets/loadproductvertical.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePages extends StatelessWidget {
  //UI load hình ảnh danh mục
  Widget _buildImageCategory(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Image.asset(
        "assets/images/$image",
        width: 55,
        height: 55,
        fit: BoxFit.fill,
      ),
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          "SHOP",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _globalKey.currentState!.openDrawer();
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
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            CarouselView(),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Danh mục",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Xem danh mục
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => (ListCategory(
                            name: "Các loại Danh mục",
                          )),
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
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildImageCategory("dienthoai.jpg"),
                  _buildImageCategory("laptop.jpg"),
                  _buildImageCategory("clothes.jpg"),
                  _buildImageCategory("shoe_dep.jpg"),
                  _buildImageCategory("doan1.jpg"),
                ],
              ),
            ),
            LoadProductVertical(name: "Sản phẩm phổ biến"),
            LoadProductHortical(name: "Sản phẩm"),
          ],
        ),
      ),
    );
  }
}
