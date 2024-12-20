import 'package:flutter/material.dart';
class Bill extends StatefulWidget {
  const Bill({super.key});

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
      child: Text("Hóa đơn",),
    );
  }
}
