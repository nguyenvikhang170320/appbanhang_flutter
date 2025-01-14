import 'package:appbanhang/model/users.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/provider/productprovider.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  final String userId; // ID của người dùng
  const Order({super.key, required this.userId});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? hoaDonStream;

  ontheload() async {
    hoaDonStream = await DatabaseMethods().getHoaDonStream();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hóa đơn",
          style: AppWidget.boldTextFeildStyle(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => BottomNav(),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
      body: StreamBuilder(
        stream: hoaDonStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    final productProvider =
                        Provider.of<ProductProvider>(context, listen: false);
                    //chuyển đổi giá trị tiền tệ
                    final locale = 'vi_VN';
                    final formatter =
                        NumberFormat.currency(name: "đ", locale: locale);
                    formatter.maximumFractionDigits = 0;
                    String price = formatter.format(ds["totalAmount"]);

                    StringBuffer productName = StringBuffer();
                    String productDes = "";
                    String productCategory = "";
                    List<dynamic> products = ds['products'] as List<dynamic>;
                    for (var product in products) {
                      productName.write('${product['productName']}, ');
                      productDes = product['productDescription'];
                      productCategory = product['productCategory'];
                      // Hiển thị thông tin sản phẩm lên giao diện
                      print('Tên sản phẩm: $productName');
                      print('Mô tả sản phẩm: $productDes');
                      print('Danh mục: $productCategory');
                    }
                    String allProductNames = productName.toString();
                    // Loại bỏ dấu phẩy thừa ở cuối chuỗi
                    allProductNames = allProductNames.substring(
                        0, allProductNames.length - 2);
                    print('Các sản phẩm: $allProductNames');
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bill header (optional)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Hóa đơn",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Add a logo or store name here (optional)
                                ],
                              ),
                              SizedBox(height: 10.0),
                              // Product details
                              Row(
                                children: [
                                  Text("Các sản phẩm:",
                                      style: AppWidget.boldTextFeildStyle()),
                                  Text(allProductNames,
                                      style: TextStyle(fontSize: 14.0)),
                                ],
                              ),

                              SizedBox(height: 5.0),

                              Row(
                                children: [
                                  Text("Giá:",
                                      style: AppWidget.boldTextFeildStyle()),
                                  Text(price,
                                      style: AppWidget.billTextFeildStyle()),
                                ],
                              ),

                              SizedBox(height: 5.0),

                              Row(
                                children: [
                                  Text("Số lượng:",
                                      style: AppWidget.boldTextFeildStyle()),
                                  Text(ds["soluongdadat"].toString(),
                                      style: AppWidget.billTextFeildStyle()),
                                ],
                              ),

                              SizedBox(height: 5.0),

                              // Customer details
                              Text("Thông tin khách hàng:",
                                  style: AppWidget.boldTextFeildStyle()),
                              Text("Người mua: " + userProvider.getNameData(),
                                  style: AppWidget.userTextFeildStyle()),
                              Text("Email: " + userProvider.getEmailData(),
                                  style: AppWidget.userTextFeildStyle()),
                              Text("SĐT: " + userProvider.getPhoneData(),
                                  style: AppWidget.userTextFeildStyle()),
                              Text("Địa chỉ: " + userProvider.getAddressData(),
                                  style: AppWidget.userTextFeildStyle()),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Text("Trạng thái:",
                                      style: AppWidget.boldTextFeildStyle()),
                                  Text(
                                    ds["status"],
                                    style: TextStyle(
                                      color: ds['status'] == 'chưa thanh toán'
                                          ? Colors.black
                                          : ds['status'] == 'đã thanh toán'
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              // Order status
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
