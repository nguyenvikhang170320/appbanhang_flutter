import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/listproduct.dart';
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
  Product(name: "Dép lê", price: 3.0, image: "shoe_dep.jpg"),
  Product(name: "Giày snecker", price: 10.0, image: "shoe.jpeg"),
  Product(name: "Quần áo", price: 15.0, image: "clothes1.jpg"),
  Product(name: "Giày da", price: 20.0, image: "shoe1.jpg"),
  Product(name: "Đôi ruốc nữ", price: 20.0, image: "shoe2.jpg"),
  Product(name: "Thịt", price: 5.0, image: "thit_ga.jpg"),
  Product(name: "Cá", price: 5.0, image: "fish.jpg"),
  Product(name: "Sửa", price: 2.0, image: "sua_khongduong.png"),
  Product(name: "Trái cây", price: 2.0, image: "traidau.png"),
  Product(name: "Bánh", price: 2.0, image: "sanwick.jpg"),
];

class LoadProductVertical extends StatelessWidget {
  final String name;
  const LoadProductVertical({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => ListProduct(),
                            ),
                          );
                        },
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 750,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                      11, // Số lượng sản phẩm
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
            ),
          ),
        ],
      ),
    );
  }
}
