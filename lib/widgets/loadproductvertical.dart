import 'package:appbanhang/pages/listproduct.dart';
import 'package:appbanhang/widgets/singleproduct.dart';
import 'package:flutter/material.dart';

class LoadProductVertical extends StatelessWidget {
  final String name;
  const LoadProductVertical({super.key, required this.name});

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
                              builder: (ctx) => ListProduct(name: "Sản phẩm"),
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
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 500,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      SingleProduct(
                          name: "Thịt bò", price: 30.0, image: "thit_bo.jpg"),
                      SingleProduct(name: "Cá", price: 25.0, image: "fish.jpg"),
                      SingleProduct(
                          name: "Dép lê", price: 35.0, image: "shoe_dep.jpg"),
                      SingleProduct(
                          name: "Giày snecker",
                          price: 40.0,
                          image: "shoe.jpeg"),
                      SingleProduct(
                          name: "Quần áo", price: 25.0, image: "clothes1.jpg"),
                      SingleProduct(
                          name: "Giày", price: 25.0, image: "shoe2.jpg"),
                    ],
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
