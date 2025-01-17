import 'package:appbanhang/pages/welcomepage.dart';
import 'package:appbanhang/services/onboard/content_model.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:flutter/material.dart';


class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 200,
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          contents[i].title,
                          style: AppWidget.semiBoolTextFeildStyle(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          contents[i].description,
                          style: AppWidget.LightTextFeildStyle(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => WelcomePage()));
              }
              _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              height: 60,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: Text(
                  currentIndex == contents.length - 1 ? "Bắt đầu" : "Tiếp tục",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.0,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black38),
    );
  }
}
