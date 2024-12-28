import 'package:appbanhang/widgets/widget_support.dart';
import 'package:flutter/material.dart';

class NameTextFormField extends StatelessWidget {
  final String? Function(String?) validator;
  final bool? Function(String?) onChanged;
  final String name;
  TextEditingController controllerUser = new TextEditingController();
  NameTextFormField(
      {super.key,
      required this.onChanged,
      required this.name,
      required this.validator,
      required this.controllerUser});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerUser,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: name,
        hintStyle: AppWidget.semiBoolTextFeildStyle(),
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(),
      ),
    );
  }
}
