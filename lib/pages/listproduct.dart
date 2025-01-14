import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/search_product.dart';
import 'package:appbanhang/provider/productprovider.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});
  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getProductItem();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget _loadProduct() {

    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    //lấy từ firebase truyền về lớp model tạo ra
                    final Products products = Products.fromFirestore(ds);
                    //chuyển đổi giá trị tiền tệ
                    final locale = 'vi_VN';
                    final formatter = NumberFormat.currency(name:"đ",locale: locale);
                    formatter.maximumFractionDigits = 0;
                    String price = formatter.format(ds["Price"]);
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
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            child: Text(
                                          ds["Name"], //tên
                                          style: AppWidget
                                              .semiBoolTextFeildStyle(),
                                        )),
                                        Container(
                                            child: Text(
                                                price.toString(), //giá
                                          style: AppWidget
                                              .semiBoolTextFeildStyle(),
                                        )),
                                      ],
                                    ),
                                  ],
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách sản phẩm",
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
                builder: (ctx) => BottomNav(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              try {
                final productProvider =
                    Provider.of<ProductProvider>(context, listen: false);
                final categories = await DatabaseMethods().fetchProducts();
                await productProvider.getSearchListProduct(
                    listproduct: categories);
                showSearch(context: context, delegate: SearchProduct());
                print("SearchProduct");
              } catch (e) {
                // Xử lý lỗi khi fetch dữ liệu
                print('Lỗi load sản phẩm: $e');
              }
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          NotificationButton(),
        ],
      ),
      body: _loadProduct(),
    );
  }
}
