import 'package:appbanhang/model/productdetail.dart';
import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/model/cartitem.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/provider/cartprovider.dart';
import 'package:appbanhang/widgets/loadproductvertical.dart';
import 'package:appbanhang/widgets/singlecartproduct.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  //text style
  final TextStyle myStyle = TextStyle(fontSize: 18);



  //build bottom giá
  Widget _buildBottomDetail(String name, String priceName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          name,
          style: myStyle,
        ),
        Text(
          priceName,
          style: myStyle,
        ),
      ],
    );
  }

  //style button
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Color.fromARGB(255, 5, 235, 74),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  // button thanh toán
  Widget _buildCheckOut() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (ctx) => CheckOut(
          //         name: widget.name, image: widget.image, price: widget.price),
          //   ),
          // );
        },
        child: Text('Thanh toán'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        width: 100,
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: _buildCheckOut(),
      ),
      appBar: AppBar(
        title: Text(
          "Đơn hàng",
          style: myStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading:  IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Trang chủ'),
                      onTap: () {
                        Navigator.pop(context); // Đóng dialog
                        //chuyển về trang chủ
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePages()));
                      },
                    ),
                    ListTile(
                      title: Text('Thêm sản phẩm mới'),
                      onTap: () {
                        Navigator.pop(context);// Đóng dialog
                        //chuyển trang danh sách sản phẩm
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ListProduct()));
                      },
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Consumer<CartProvider>(builder: (context, cart, child) {
        // print(2);
        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];
            return Container(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 120,
                              width: 120,
                              child: Image.network(item.products.image),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 120,
                              width: 160,
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.products.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Size:  ${item.size}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 20,
                                      child: Row(
                                        children: [
                                          Text("Màu: "),
                                          Text("${item.color}"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 20,
                                      child: Row(
                                        children: [
                                          Text("Số lượng: "),
                                          Text("${item.quantity}"),
                                        ],
                                      ),
                                    ),

                                    Text(
                                      "Giá: \$ ${item.products.price}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                print("delete");
                                cart.removeItem(item);
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            );
          },
        );
      }),
      bottomSheet: Consumer<CartProvider>(builder: (context, cart, child) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBottomDetail(
                "Tổng cộng:", cart.formattedPrice.toString()),
            _buildBottomDetail(
                "Giảm giá:", cart.discount.toString()+"\%"),
            _buildBottomDetail(
                "Phí vận chuyển:",
                cart.shipCode(cart.subTotalPrice).toString()),
            _buildBottomDetail("Thành tiền:",
                cart.formattedTotalPrice.toString()),
          ],
        ),
      );
    }),
    );
  }
}
