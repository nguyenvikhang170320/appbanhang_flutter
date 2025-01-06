import 'package:appbanhang/model/colorsize.dart';
import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/pages/checkout.dart';
import 'package:appbanhang/provider/cartprovider.dart';
import 'package:appbanhang/services/databasemethod.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

import '../model/products.dart';

class DetailPage extends StatefulWidget {
  final Products products;

  DetailPage({required this.products});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1; //tăng-giảm số lượng
  String _selectedSize = ""; // Selected size
  //text style
  final TextStyle myStyle = TextStyle(fontSize: 18);
  String selectedColor = '';
  bool get showVariantOptions =>
      !["đồ ăn", "đồ uống", "trái cây", "thực phẩm", "kem", "laptop","điện thoại","sách","thú cưng"].contains(widget.products.category);

  bool categoryRequiresSizeColor = false;


  //chọn màu
  Widget buildColorProduct() {
    return  DropdownButton<String>(
      value: selectedColor,
      onChanged: (value) {
        setState(() {
          selectedColor = value!;
          Provider.of<CartProvider>(context, listen: false).discountColor =
              value;
        });
        // Cập nhật mức giảm giá cho CartProvider
      },
      items: [
        DropdownMenuItem(value: '', child: Text('không có màu')),
        DropdownMenuItem(value: 'trắng', child: Text('Màu trắng')),
        DropdownMenuItem(value: 'đen', child: Text('Màu đen')),
        DropdownMenuItem(value: 'đỏ', child: Text('Màu đỏ')),
        DropdownMenuItem(value: 'vàng', child: Text('Màu vàng')),
        DropdownMenuItem(value: 'tím', child: Text('Màu tím')),
        DropdownMenuItem(value: 'xanh', child: Text('Màu xanh')),
        DropdownMenuItem(value: 'nâu', child: Text('Màu nâu')),
      ],
    );
  }

  //chọn màu
  Widget _buildColor() {
    if(showVariantOptions){
      print('showVariantOptions: $showVariantOptions');
      print('widget.products.category: ${widget.products.category}');
      categoryRequiresSizeColor = true;
    // Giả sử bạn đã có một danh sách các danh mục cần chọn size và màu sắc
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Màu",
            style: myStyle,
          ),
          buildColorProduct(),
        ],
      );
    }else{
      print('showVariantOptions: $showVariantOptions');
      categoryRequiresSizeColor = false;
      return SizedBox();
    }
  }

  //chọn size
  Widget _buildSize() {

    if (showVariantOptions) {
      print('showVariantOptions: $showVariantOptions');
      categoryRequiresSizeColor = true;//ko cho hiển thị size, màu sắc
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
              _buildSizeProduct("S",
                  onTap: () => setState(() => _selectedSize = "S")),
              _buildSizeProduct("M",
                  onTap: () => setState(() => _selectedSize = "M")),
              _buildSizeProduct("L",
                  onTap: () => setState(() => _selectedSize = "L")),
              _buildSizeProduct("XL",
                  onTap: () => setState(() => _selectedSize = "XL")),
              _buildSizeProduct("XXL",
                  onTap: () => setState(() => _selectedSize = "XXL")),
            ],
          ),
        ],
      );
    } else {
      print('showVariantOptions: $showVariantOptions');
      categoryRequiresSizeColor = false; // cho hiển thị size, màu sắc
      return SizedBox();
    }
  }

  //chọn size
  Widget _buildSizeProduct(String size, {VoidCallback? onTap}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _selectedSize == size
            ? Colors.blue
            : null, // Highlight selected size
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 60,
        height: 30,
        child: TextButton(
          onPressed: onTap,
          child: Text(
            size,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //load hình ảnh
  Widget _buildImage() {
    return Container(
      width: 320,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 220,
            child: Image.network(widget.products.image),
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
              Text(widget.products.name, style: myStyle),
              Text(
                "Giá",
                style: myStyle,
              ),
              Text(
                "\$ ${widget.products.price.toString()}",
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
            widget.products.description,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
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

  //style button
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        width: 100,
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 60,
          width: 100,
          padding: EdgeInsets.only(bottom: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 60,
            width: 150,
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () async {
                // print(1);
                final ColorSize colorSize;

                cart.addItem(widget.products, _selectedSize,selectedColor, count);
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                try {
                  await DatabaseMethods().addColorSizeProduct(widget.products, selectedColor,_selectedSize, categoryRequiresSizeColor);
                  print('Thêm đơn hàng thành công');
                  ToastService.showSuccessToast(context,
                      length: ToastLength.medium,
                      expandedHeight: 100,
                      message: "Thêm sản phẩm vào giỏ hàng thành công");

                } catch (e) {
                  print('Lỗi khi thêm sản phẩm: $e');
                }

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CheckOut(),
                  ),
                );
              },
              child: Text('Thêm vào giỏ hàng'),
            ),
          ),
        ),
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
         NotificationButton(),
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
