import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String name;
  TextEditingController controllerUser = new TextEditingController();
  MyTextFormField(
      {super.key,
      required this.name,
      required this.controllerUser});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerUser,
      decoration: InputDecoration(
        hintText: name,
        hintStyle: AppWidget.semiBoolTextFeildStyle(),
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(),
      ),
    );
  }
}
