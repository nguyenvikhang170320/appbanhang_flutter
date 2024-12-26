import 'package:appbanhang/pages/cartpage.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  final String name;
  final String image;
  final double price;

  CheckOut(
      {super.key,
      required this.name,
      required this.image,
      required this.price});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  //text style
  final TextStyle myStyle = TextStyle(fontSize: 18);
  int count = 1;
  //build widget tất cả cart
  Widget _buildSingleCartProduct() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/${widget.image}"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  height: 140,
                  width: 140,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Shop bán hàng",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "\$${widget.price.toString()}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
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

  //số lượng
  Widget _buildQuantity() {
    return Container(
      width: 120,
      height: 20,
      child: Row(
        children: [
          Text("Số lượng"),
          Text("1"),
        ],
      ),
    );
  }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            // quay về trang chi tiết sản phẩm truyền dữ liệu về trang
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(
                  name: widget.name,
                  image: widget.image,
                  price: widget.price,
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
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSingleCartProduct(),
                  _buildSingleCartProduct(),
                  _buildSingleCartProduct(),
                  Container(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildBottomDetail("Giá:", "\$ 60.00"),
                        _buildBottomDetail("Giảm %:", "3%"),
                        _buildBottomDetail("Giá ship code:", "\$ 30.00"),
                        _buildBottomDetail("Tổng cộng:", "\$ 90.00"),
                      ],
                    ),
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
