import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselView extends StatelessWidget {
  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/foodappflutter-d99ee.appspot.com/o/sliderbar_appbanhang%2Fappbanhang1.jpg?alt=media&token=ec09f148-480b-4b01-a73f-b8cfaff45d00",
    "https://firebasestorage.googleapis.com/v0/b/foodappflutter-d99ee.appspot.com/o/sliderbar_appbanhang%2Fappbanhang2.jpg?alt=media&token=4b3f75d7-6ba0-4082-9da1-9796d0bc840b",
    "https://firebasestorage.googleapis.com/v0/b/foodappflutter-d99ee.appspot.com/o/sliderbar_appbanhang%2Fappbanhang.png?alt=media&token=4696c94f-b564-436f-8507-90bd932aba51",
    "https://firebasestorage.googleapis.com/v0/b/foodappflutter-d99ee.appspot.com/o/sliderbar_appbanhang%2Fapp-ban-hang.png?alt=media&token=ffd9614b-c1b4-49cc-a2b0-c8f22b932d6f",
    "https://firebasestorage.googleapis.com/v0/b/foodappflutter-d99ee.appspot.com/o/sliderbar_appbanhang%2Fapp-ban-hang-online.png?alt=media&token=7257b28f-3f18-42c7-b2a3-d21478244c75",
    "https://firebasestorage.googleapis.com/v0/b/foodappflutter-d99ee.appspot.com/o/sliderbar_appbanhang%2Fabout.jpg?alt=media&token=f41ef007-9993-45a5-8796-2545730d8adc"
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
