import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

List<Product> products = [
  Product(name: "Laptop", price: 600.0, image: "laptop.jpg"),
  Product(name: "Điện thoại", price: 300.0, image: "dienthoai.jpg"),
  Product(name: "Bánh mì sandwich", price: 2.0, image: "sanwick.jpg"),
  Product(name: "Kem", price: 2.0, image: "kem.jpg"),
  Product(name: "Thịt bò", price: 5.0, image: "thit_bo.jpg"),
  Product(name: "Thịt heo", price: 5.0, image: "thit_heo.jpg"),
  Product(name: "Thịt gà", price: 5.0, image: "thit_ga.jpg"),
  Product(name: "Cá", price: 5.0, image: "fish.jpg"),
  Product(name: "Đôi ruốc nữ", price: 20.0, image: "shoe2.jpg"),
  Product(name: "Thịt", price: 5.0, image: "thit_ga.jpg"),
  Product(name: "Cá", price: 5.0, image: "fish.jpg"),
  Product(name: "Quần áo hàn quốc", price: 15.0, image: "clothes.jpg"),
  Product(name: "Quần áo", price: 15.0, image: "clothes1.jpg"),
  Product(name: "Giày da của nam", price: 20.0, image: "shoe1.jpg"),
  Product(name: "Giày sneaker nam", price: 10.0, image: "shoe.jpeg"),
  Product(name: "Đôi guốc của nữ", price: 20.0, image: "shoe2.jpg"),
  Product(name: "Dép lê", price: 3.0, image: "shoe_dep.jpg"),
  Product(name: "Sửa Arla", price: 2.0, image: "sua_arla.jpg"),
  Product(
      name: "Sửa tươi không đường", price: 2.0, image: "sua_khongduong.png"),
  Product(name: "Trái cam", price: 2.0, image: "traicam.png"),
  Product(name: "Trái chuối", price: 2.0, image: "traichuoi.png"),
  Product(name: "Trái dâu", price: 2.0, image: "traidau.png"),
  Product(name: "Trái nho", price: 2.0, image: "trainho.png"),
  Product(name: "Trái thanh long", price: 2.0, image: "traithanhlong.png"),
];

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
          margin: EdgeInsets.fromLTRB(10, 10, 5, 5),
          child: Column(
            children: <Widget>[
              Container(
                height: 700,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.8,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    24, // Số lượng sản phẩm
                    (index) {
                      final product = products[
                          index]; // Lấy thông tin sản phẩm từ danh sách
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => DetailPage(
                                name: product.name,
                                price: product.price,
                                image: product.image,
                              ),
                            ),
                          );
                        },
                        child: SingleProduct(
                          name: product.name,
                          price: product.price,
                          image: product.image,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
