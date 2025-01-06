import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselView extends StatelessWidget {
  final List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7FLN0H9DhNFztJl8WFIdGlPrxNCU43RMrSA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnLT3cQFDm_FRe_jhZF1cTj0Eg0LCQ0u6nDQ&s",
    "https://www.ansto.gov.au/sites/default/files/styles/hero_image/public/hero-images/Healthy%20food.jpg?h=10d202d3&itok=d0dHqxZq"
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imageList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Image.network(i));
          },
        );
      }).toList(),
    );
  }
}
