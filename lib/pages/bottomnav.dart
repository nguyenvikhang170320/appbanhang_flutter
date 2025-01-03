import 'package:appbanhang/pages/account.dart';
import 'package:appbanhang/pages/favorites.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/bill.dart';
import 'package:appbanhang/pages/postproduct.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePages home;
  late Account account;
  late Favorites favorites;
  late PostProduct postProduct;
  late Bill bill;

  @override
  void initState() {
    home = HomePages();
    account = Account();
    favorites = Favorites();
    postProduct = PostProduct();
    bill = Bill();
    pages = [home, postProduct, bill, favorites, account];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.yellow,
          color: Colors.blue,
          animationDuration: Duration(milliseconds: 300),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.add_a_photo_outlined,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.wallet_giftcard_outlined,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.favorite_border_outlined,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.person_outlined,
              size: 30,
              color: Colors.black,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
