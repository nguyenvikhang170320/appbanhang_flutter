import 'package:appbanhang/pages/listcategory.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/widgets/carouselview.dart';
import 'package:appbanhang/widgets/loadproducthortical.dart';
import 'package:appbanhang/widgets/loadproductvertical.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePages extends StatefulWidget {
  HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  //UI load hình ảnh danh mục
  Widget _buildImageCategory(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Image.asset(
        "assets/images/$image",
        width: 80,
        height: 80,
        fit: BoxFit.fill,
      ),
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool homeColor = true;

  bool cartColor = false;

  bool billColor = false;

  bool doanhthuColor = false;

  bool walletColor = false;

  bool aboutColor = false;

  bool callColor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/shop1.jpg"),
                radius: 30,
              ),
              accountName: Text(
                "Ken",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "ken@gmail.com",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  homeColor = true;
                  cartColor = false;
                  billColor = false;
                  doanhthuColor = false;
                  walletColor = false;
                  aboutColor = false;
                  callColor = false;
                });
              },
              title: Text("Trang chủ"),
              leading: Icon(Icons.home),
              selected: homeColor,
            ),
            ListTile(
              onTap: () {
                //giỏ hàng
                setState(() {
                  homeColor = false;
                  cartColor = true;
                  billColor = false;
                  doanhthuColor = false;
                  walletColor = false;
                  aboutColor = false;
                  callColor = false;
                });
              },
              title: Text("Giỏ hàng"),
              leading: Icon(Icons.shopping_cart),
              selected: cartColor,
            ),
            ListTile(
              onTap: () {
                //hóa đơn
                setState(() {
                  homeColor = false;
                  cartColor = false;
                  billColor = true;
                  doanhthuColor = false;
                  walletColor = false;
                  aboutColor = false;
                  callColor = false;
                });
              },
              title: Text("Hóa đơn"),
              leading: Icon(Icons.wallet_giftcard_outlined),
              selected: billColor,
            ),
            ListTile(
              onTap: () {
                //doanh thu
                setState(() {
                  homeColor = false;
                  cartColor = false;
                  billColor = false;
                  doanhthuColor = true;
                  walletColor = false;
                  aboutColor = false;
                  callColor = false;
                });
              },
              title: Text("Doanh thu"),
              leading: Icon(Icons.insert_chart),
              selected: doanhthuColor,
            ),
            ListTile(
              onTap: () {
                //thẻ ngân hàng
                setState(() {
                  homeColor = false;
                  cartColor = false;
                  billColor = false;
                  doanhthuColor = false;
                  walletColor = true;
                  aboutColor = false;
                  callColor = false;
                });
              },
              title: Text("Thẻ ngân hàng"),
              leading: Icon(Icons.add_card),
              selected: walletColor,
            ),
            ListTile(
              onTap: () {
                //thông tin
                setState(() {
                  homeColor = false;
                  cartColor = false;
                  billColor = false;
                  doanhthuColor = false;
                  walletColor = false;
                  aboutColor = true;
                  callColor = false;
                });
              },
              title: Text("Thông tin"),
              leading: Icon(Icons.info),
              selected: aboutColor,
            ),
            ListTile(
              onTap: () {
                //gọi điện
                setState(() {
                  homeColor = false;
                  cartColor = false;
                  billColor = false;
                  doanhthuColor = false;
                  walletColor = false;
                  aboutColor = false;
                  callColor = true;
                });
              },
              title: Text("Gọi điện"),
              leading: Icon(Icons.phone),
              selected: callColor,
            ),
            ListTile(
              onTap: () {
                //đăng xuất
                setState(() {});
              },
              title: Text("Đăng xuất"),
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
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
                          builder: (ctx) => ListCategory(),
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
              child: GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildImageCategory("dienthoai.jpg"),
                  _buildImageCategory("laptop.jpg"),
                  _buildImageCategory("clothes.jpg"),
                  _buildImageCategory("shoe_dep.jpg"),
                  _buildImageCategory("shoe.jpeg"),
                  _buildImageCategory("sanwick.jpg"),
                  _buildImageCategory("kem.jpg"),
                  _buildImageCategory("traidau.png"),
                  _buildImageCategory("thit_ga.jpg"),
                  _buildImageCategory("fish.jpg"),
                ],
              ),
            ),
            LoadProductHortical(name: "Sản phẩm phổ biến"),
            LoadProductVertical(name: "Sản phẩm"),
          ],
        ),
      ),
    );
  }
}
