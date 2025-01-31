import 'package:appbanhang/pages/admin/add_featureroduct.dart';
import 'package:appbanhang/pages/admin/add_productmoi.dart';
import 'package:appbanhang/pages/admin/add_category.dart';
import 'package:appbanhang/pages/admin/add_products.dart';
import 'package:appbanhang/pages/admin/admin_login.dart';
import 'package:appbanhang/pages/admin/orders.dart';
import 'package:appbanhang/pages/admin/revenue.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              //chuyển màn hình
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AdminLogin()));
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF373866),
            )),
        centerTitle: true,
        title: Text(
          "Trang người quản trị",
          style: AppWidget.HeadlineTextFeildStyle(),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Orders()));
                  },
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image.asset(
                                "assets/images/admin.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Hóa đơn",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Revenue()));
                  },
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image.asset(
                                "assets/images/admin.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Doanh thu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCategory()));
                  },
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image.asset(
                                "assets/images/admin.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Thêm danh mục",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddProducts()));
                  },
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image.asset(
                                "assets/images/admin.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Thêm sản phẩm",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductMoi()));
                  },
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image.asset(
                                "assets/images/admin.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Thêm sản phẩm mới",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFeatureProduct()));
                  },
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image.asset(
                                "assets/images/admin.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Thêm sản phẩm nổi bật",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
