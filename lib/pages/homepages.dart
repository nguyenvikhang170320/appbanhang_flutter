import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePages extends StatelessWidget {
  Widget _buildProduct(String name, double price, String image) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 220,
        width: 150,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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

  Widget _buildCategory(String image) {
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
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
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
              height: 120,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Tìm kiếm sản phẩm",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nổi bật",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        _buildProduct("Thịt bò", 30.0, "thit_bo.jpg"),
                        _buildProduct("Thịt heo", 35.0, "thit_heo.jpg"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 70,
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
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: <Widget>[
                  _buildCategory("shoe.jpeg"),
                  SizedBox(
                    width: 5,
                  ),
                  _buildCategory("clothes.jpg"),
                  SizedBox(
                    width: 5,
                  ),
                  _buildCategory("shoe1.jpg"),
                  SizedBox(
                    width: 5,
                  ),
                  _buildCategory("shoe_dep.jpg"),
                  SizedBox(
                    width: 5,
                  ),
                  _buildCategory("shop.jpg"),
                ],
              ),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sản phầm",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tất cả",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          _buildProduct("Cá", 30.0, "fish.jpg"),
                          _buildProduct("Thịt gà", 34.0, "thit_ga.jpg"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
