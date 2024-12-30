import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/cartpage.dart';
import 'package:appbanhang/widgets/loadproductvertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/products.dart';

class DetailPage extends StatefulWidget {
  final Products product;

  DetailPage({
    required this.product
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1; //tăng-giảm số lượng

  //chọn màu sắc sản phẩm
  Widget _buildColorProduct({Color? color}) {
    print(color);
    return Container(
      height: 60,
      width: 60,
      color: color ?? Colors.black,
    );
  }

  //image
  Widget _buildImage() {
    return Container(
      width: 320,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 220,
            child: Image.network(widget.product.image),
          ),
        ),
      ),
    );
  }

  //tên sản phẩm and chữ mô tả
  Widget _buildNameAndDescription() {
    return Container(
      height: 150,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sản phẩm",
                style: myStyle,
              ),
              Text(widget.product.name, style: myStyle),
              Text(
                "Giá",
                style: myStyle,
              ),
              Text(
                "\$ ${widget.product.price.toString()}",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              Text(
                "Mô tả",
                style: myStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //mô tả sản phẩm
  Widget _buildDescription() {
    return Container(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          Text(
            widget.product.description,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  //chọn size sản phẩm
  Widget _buildSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Size",
          style: myStyle,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSizeProduct("S"),
            _buildSizeProduct("M"),
            _buildSizeProduct("L"),
            _buildSizeProduct("XL"),
            _buildSizeProduct("XXL"),
          ],
        ),
      ],
    );
  }

//chọn size sản phẩm
  Widget _buildSizeProduct(String name) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        name,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  //màu
  Widget _buildColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Màu",
          style: myStyle,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildColorProduct(color: Colors.red),
            _buildColorProduct(color: Colors.yellow),
            _buildColorProduct(color: Colors.lightBlue),
            _buildColorProduct(color: Colors.brown),
            _buildColorProduct(color: Colors.grey),
          ],
        ),
      ],
    );
  }

  //số lượng tăng giảm
  Widget _buildQuantity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Số lượng",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
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
        ),
      ],
    );
  }

  //button thêm vào giỏ hàng
  Widget _buildAddToCart() {
    return Container(
      height: 60,
      width: 150,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (ctx) => CartPage(

          //     ),
          //   ),
          // );
        },
        child: Text('Thêm vào giỏ hàng'),
      ),
    );
  }

  //style button
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  //text style
  final TextStyle myStyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        width: 100,
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: _buildAddToCart(),
      ),
      appBar: AppBar(
        title: Text(
          "Chi tiết sản phẩm",
          style: myStyle,
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
        child: ListView(
          children: [
            _buildImage(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNameAndDescription(), // tên sản phẩm and chữ mô tả
                  _buildDescription(), // mô tả sản phẩm

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSize(),
                      SizedBox(
                        height: 10,
                      ),
                      _buildColor(), // màu sản phẩm
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildQuantity(), // số lượng tăng giảm sản phẩm
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
