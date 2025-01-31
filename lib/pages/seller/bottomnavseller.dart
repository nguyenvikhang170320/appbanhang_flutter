import 'package:appbanhang/pages/admin/admin_login.dart';
import 'package:appbanhang/pages/admin/orders.dart';
import 'package:appbanhang/pages/checkout.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/pages/order.dart';
import 'package:appbanhang/pages/profile.dart';
import 'package:appbanhang/pages/seller/profileseller.dart';
import 'package:appbanhang/provider/userprovider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavSeller extends StatefulWidget {
  const BottomNavSeller({super.key});
  @override
  State<BottomNavSeller> createState() => _BottomNavSellerState();
}

class _BottomNavSellerState extends State<BottomNavSeller> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePages home;
  late ProfileSeller profileSeller;
  late AdminLogin adminLogin;
  late CheckOut checkOut;
  late Order order;

  @override
  void initState() {
    // final user = Provider.of<UserProvider>(context, listen: false);
    home = HomePages();
    profileSeller = ProfileSeller();
    adminLogin = AdminLogin();
    checkOut = CheckOut();
    order = Order(
      // userId: user.getUidData(),
    );
    pages = [home, checkOut, order,  profileSeller, adminLogin,];
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
              Icons.person_outlined,
              size: 30,
              color: Colors.black,
            ),
            Icon(
              Icons.admin_panel_settings_rounded,
              size: 30,
              color: Colors.black,
            ),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
