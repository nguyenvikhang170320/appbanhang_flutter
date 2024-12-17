import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  const SingleProduct(
      {super.key,
      required this.name,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 220,
        width: 150,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/images/$image")),
              ),
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
