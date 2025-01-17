import 'package:appbanhang/pages/checkout.dart';
import 'package:appbanhang/pages/favorites.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/order.dart';
import 'package:appbanhang/pages/profile.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late Profile profile;
  late Favorites favorites;
  late CheckOut checkOut;
  late Order order;

  @override
  void initState() {
    final user = Provider.of<UserProvider>(context, listen: false);
    home = HomePages();
    profile = Profile();
    favorites = Favorites();
    checkOut = CheckOut();
    order = Order(
      userId: user.getUidData(),
    );
    pages = [home, checkOut, order, favorites, profile];
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
              Icons.shopping_cart,
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
