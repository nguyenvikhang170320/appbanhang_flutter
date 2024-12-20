import 'package:flutter/material.dart';
class Notifications extends StatefulWidget {
  const Notifications ({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
      child: Text("Thông báo"),
    );
  }
}
