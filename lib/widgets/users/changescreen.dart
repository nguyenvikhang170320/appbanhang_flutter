import 'package:flutter/material.dart';

class ChangeScreen extends StatelessWidget {
  final void Function() onTap;
  final String name;
  final String whichAccount;
  ChangeScreen(
      {super.key,
      required this.name,
      required this.whichAccount,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          whichAccount,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            name,
            style: TextStyle(
                color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
