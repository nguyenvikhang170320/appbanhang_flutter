import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:appbanhang/provider/productprovider.dart';
class NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 3, end: 6),
      badgeContent: Text(
       productProvider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Colors.red,
      ),
      child: IconButton(
        icon: Icon(Icons.notifications_none),
        color: Colors.black,
        onPressed: () {},
      ),
    );
  }
}
