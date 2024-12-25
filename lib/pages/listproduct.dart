import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});
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
                builder: (ctx) => HomePages(),
              ),
            );
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
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                height: 750,
                width: 400,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SingleProduct(
                        name: "Điện thoại",
                        price: 300.0,
                        image: "dienthoai.jpg"),
                    SingleProduct(
                        name: "Laptop", price: 600.0, image: "laptop.jpg"),
                    SingleProduct(
                        name: "Bánh mì sandwich",
                        price: 2.0,
                        image: "sanwick.jpg"),
                    SingleProduct(name: "Kem", price: 2.0, image: "kem.jpg"),
                    SingleProduct(
                        name: "Thịt bò", price: 5.0, image: "thit_bo.jpg"),
                    SingleProduct(
                        name: "Thịt heo", price: 5.0, image: "thit_heo.jpg"),
                    SingleProduct(
                        name: "Thịt gà", price: 5.0, image: "thit_ga.jpg"),
                    SingleProduct(name: "Cá", price: 5.0, image: "fish.jpg"),
                    SingleProduct(
                        name: "Quần áo", price: 15.0, image: "clothes.jpg"),
                    SingleProduct(
                        name: "Quần áo", price: 15.0, image: "clothes1.jpg"),
                    SingleProduct(
                        name: "Giày da của nam",
                        price: 20.0,
                        image: "shoe1.jpg"),
                    SingleProduct(
                        name: "Đôi guốc của nữ",
                        price: 20.0,
                        image: "shoe2.jpg"),
                    SingleProduct(
                        name: "Giày sneaker nam",
                        price: 10.0,
                        image: "shoe.jpeg"),
                    SingleProduct(
                        name: "Dép lê", price: 3.0, image: "shoe_dep.jpg"),
                    SingleProduct(
                        name: "Sửa Arla", price: 2.0, image: "sua_arla.jpg"),
                    SingleProduct(
                        name: "Sửa tươi không đường",
                        price: 2.0,
                        image: "sua_khongduong.png"),
                    SingleProduct(
                        name: "Trái cam", price: 2.0, image: "traicam.png"),
                    SingleProduct(
                        name: "Trái chuối", price: 2.0, image: "traichuoi.png"),
                    SingleProduct(
                        name: "Trái dâu", price: 2.0, image: "traidau.png"),
                    SingleProduct(
                        name: "Trái nho", price: 2.0, image: "trainho.png"),
                    SingleProduct(
                        name: "Trái thanh long",
                        price: 2.0,
                        image: "traithanhlong.png"),
                    SingleProduct(
                        name: "Trái dưa hấu",
                        price: 2.0,
                        image: "traiduahau.png"),
                    SingleProduct(
                        name: "Trái đu đủ", price: 2.0, image: "traidudu.png"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
