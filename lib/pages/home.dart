import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
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

  //UI tìm kiếm - nỗi bật - xem tất cả
  Widget _buildProduct() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                        "Sản phẩm nổi bật",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Xem tất cả",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      SingleProduct(
                          name: "Thịt bò", price: 30.0, image: "thit_bo.jpg"),
                      SingleProduct(name: "Cá", price: 25.0, image: "fish.jpg"),
                      SingleProduct(
                          name: "Dép lê", price: 35.0, image: "shoe_dep.jpg"),
                      SingleProduct(
                          name: "Giày snecker",
                          price: 40.0,
                          image: "shoe.jpeg"),
                      SingleProduct(
                          name: "Quần áo", price: 25.0, image: "clothes1.jpg"),
                      SingleProduct(
                          name: "Giày", price: 25.0, image: "shoe2.jpg"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductNew() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(
                        "Xem tất cả",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SingleProduct(
                          name: "Thịt bò", price: 30.0, image: "thit_bo.jpg"),
                      SingleProduct(
                          name: "Thịt heo", price: 35.0, image: "thit_heo.jpg"),
                      SingleProduct(
                          name: "Thịt gà", price: 25.0, image: "thit_ga.jpg"),
                      SingleProduct(
                          name: "Dép lê", price: 35.0, image: "shoe_dep.jpg"),
                      SingleProduct(
                          name: "Giày snecker",
                          price: 40.0,
                          image: "shoe.jpeg"),
                      SingleProduct(name: "Cá", price: 25.0, image: "fish.jpg"),
                      SingleProduct(
                          name: "Quần áo", price: 25.0, image: "clothes.jpg"),
                      SingleProduct(
                          name: "Quần áo", price: 25.0, image: "clothes1.jpg"),
                      SingleProduct(
                          name: "Giày", price: 25.0, image: "shoe1.jpg"),
                      SingleProduct(
                          name: "Giày", price: 25.0, image: "shoe2.jpg"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  Home({super.key});

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
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Danh mục",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tất cả",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildImageCategory("shoe.jpeg"),
                  _buildImageCategory("clothes.jpg"),
                  _buildImageCategory("shoe1.jpg"),
                  _buildImageCategory("shoe_dep.jpg"),
                  _buildImageCategory("fish.jpg"),
                ],
              ),
            ),
            _buildProduct(),
            _buildProductNew()
          ],
        ),
      ),
    );
  }
}
