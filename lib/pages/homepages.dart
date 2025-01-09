import 'package:appbanhang/admin/admin_login.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/checkout.dart';
import 'package:appbanhang/pages/welcomepage.dart';
import 'package:appbanhang/pages/listcategory.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:appbanhang/services/auth.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/slidebar/carouselview.dart';
import 'package:appbanhang/widgets/products/loadproducthortical.dart';
import 'package:appbanhang/widgets/products/loadproductvertical.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class HomePages extends StatefulWidget {

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final AuthMethods authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUserData(); //được gọi trước khi build widget
  }
  //UI load hình ảnh danh mục
  Widget _buildImageCategory(String image) {
    return Container(
      width: 30, // Set a fixed width for the images
      height: 30, // Set a fixed height for the images
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(60), // Adjust radius for perfect circle
        child: Image.asset(
          "assets/images/$image",
          fit: BoxFit.cover, // Ensure image fills the circular area
        ),
      ),
    );
  }

  Widget _buildMyDrawer() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: true);
    print(userProvider);
    return Drawer(
      child: ListView(
        children: <Widget>[
      UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.white),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage("assets/images/shop1.jpg"),
        radius: 30,
      ),
      accountName: Text(
        userProvider.getNameData(),
        style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        userProvider.getEmailData(),
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => BottomNav(),
                  ),
                );
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CheckOut(),
                ),
              );
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
            title: Text("Liên hệ chúng tôi"),
            leading: Icon(Icons.contact_emergency),
            selected: callColor,
          ),
          ListTile(
            onTap: (){
              //đăng xuất
              setState(() {
                authMethods.SignOut();
                userProvider.signOut();
              });
              //show thông báo dạng toasty
              ToastService.showSuccessToast(context,
                  length: ToastLength.medium,
                  expandedHeight: 100,
                  message: "Đăng xuất thành công");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => WelcomePage()));
            },
            title: Text("Đăng xuất"),
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderDanhmuc() {
    return Container(
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
    );
  }

  Widget _buildDanhmuc() {
    return Container(
      height: 50,
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
        ],
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
      drawer: _buildMyDrawer(),
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
          NotificationButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselView(),
              SizedBox(
                height: 10,
              ),
              _buildHeaderDanhmuc(),
              SizedBox(
                height: 10,
              ),
              _buildDanhmuc(),
              SizedBox(
                height: 10,
              ),
              LoadProductHortical(),
              SizedBox(
                height: 10,
              ),
              LoadProductVertical(),
            ],
          ),
        ),
      ),
    );
  }
}
