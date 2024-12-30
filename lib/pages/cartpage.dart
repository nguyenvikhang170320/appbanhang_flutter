import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/pages/checkout.dart';
import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String description;
  final Products products;
  CartPage(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.description,
      required this.products});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //text style
  final TextStyle myStyle = TextStyle(fontSize: 18);
  //tạo biến count
  int count = 1;
  //style button
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Color.fromARGB(255, 23, 240, 88),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  //tăng giảm số lượng
  Widget _buildQuantity() {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Icon(Icons.remove),
            onTap: () {
              setState(() {
                if (count > 1) {
                  count--;
                }
              });
            },
          ),
          Text(
            count.toString(),
            style: myStyle,
          ),
          GestureDetector(
            child: Icon(Icons.add),
            onTap: () {
              setState(() {
                count++;
              });
            },
          )
        ],
      ),
    );
  }

  // button đặt hàng
  Widget _buildCheckOut() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CheckOut(
                name: widget.name,
                image: widget.image,
                price: widget.price,
                description: widget.description,
              ),
            ),
          );
        },
        child: Text('Đặt hàng'),
      ),
    );
  }

  Widget _buildSingleCartProduct() {
    return Container(
      height: 200,
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: 120,
                  child: Image.network(widget.image),
                ),
                Container(
                  height: 160,
                  width: 200,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${widget.price.toString()}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.red),
                        ),
                        Text(
                          "Màu",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        _buildQuantity(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          "Giỏ hàng",
          style: myStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // quay về trang chi tiết sản phẩm truyền dữ liệu về trang
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  product: widget.products,
                ),
              ),
            );
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
        ],
      ),
      body: ListView(
        children: [
          _buildSingleCartProduct(),
          _buildSingleCartProduct(),
          _buildSingleCartProduct(),
          _buildSingleCartProduct(),
          _buildSingleCartProduct(),
          _buildSingleCartProduct(),
        ],
      ),
    );
  }
}
