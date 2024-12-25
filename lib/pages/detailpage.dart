import 'package:appbanhang/pages/homepages.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  DetailPage(
      {super.key,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1; //tăng-giảm số lượng

//chọn size sản phẩm
  Widget _buildSizeProduct(String name) {
    return Container(
      height: 60,
      width: 60,
      color: Colors.grey,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

//chọn màu sắc sản phẩm
  Widget _buildColorProduct({Color? color}) {
    print(color);
    return Container(
      height: 60,
      width: 60,
      color: color ?? Colors.black,
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
                builder: (ctx) => HomePages(),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 320,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage("assets/images/${widget.image}"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 80,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.name, style: myStyle),
                                Text(
                                  "\$ ${widget.price.toString()}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                                Text(
                                  "Mô tả",
                                  style: myStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              "Chúng ta vẫn biết rằng, làm việc với một đoạn văn bản dễ đọc và rõ nghĩa dễ gây rối trí và cản trở việc tập trung vào yếu tố trình bày văn bản. Lorem Ipsum có ưu điểm hơn so với đoạn văn bản chỉ gồm nội dung kiểu Nội dung là nó khiến văn bản giống thật hơn, bình thường hơn. Nhiều phần mềm thiết kế giao diện web và dàn trang ngày nay đã sử dụng Lorem Ipsum làm đoạn văn bản giả, và nếu bạn thử tìm các đoạn. Lorem ipsum trên mạng thì sẽ khám phá ra nhiều trang web hiện vẫn đang trong quá trình xây dựng. Có nhiều phiên bản khác nhau đã xuất hiện, đôi khi do vô tình, nhiều khi do cố ý (xen thêm vào những câu hài hước hay thông tục).",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
                      ),
                      Text(
                        "Size",
                        style: myStyle,
                      ),
                      Container(
                        width: 270,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildSizeProduct("S"),
                            _buildSizeProduct("M"),
                            _buildSizeProduct("L"),
                            _buildSizeProduct("XXL"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Màu",
                        style: myStyle,
                      ),
                      Container(
                        width: 320,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildColorProduct(color: Colors.red),
                            _buildColorProduct(color: Colors.yellow),
                            _buildColorProduct(color: Colors.lightBlue),
                            _buildColorProduct(color: Colors.brown),
                            _buildColorProduct(color: Colors.grey),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(200, 5, 5, 5),
                        height: 40,
                        width: 140,
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {},
                          child: Text('Thanh toán'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
