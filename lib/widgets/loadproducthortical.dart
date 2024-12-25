import 'package:appbanhang/pages/detailpage.dart';
import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

List<Product> products = [
  Product(name: "Laptop", price: 600.0, image: "laptop.jpg"),
  Product(name: "Điện thoại", price: 300.0, image: "dienthoai.jpg"),
  Product(name: "Quần áo", price: 15.0, image: "clothes1.jpg"),
  Product(name: "Giày", price: 10.0, image: "shoe2.jpg"),
  Product(name: "Sửa", price: 3.0, image: "sua_khongduong.png"),
  Product(name: "Trái cây", price: 3.0, image: "traidau.png"),
];

class LoadProductHortical extends StatelessWidget {
  final String name;
  const LoadProductHortical({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 180,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      6, // Số lượng sản phẩm
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
