import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:flutter/material.dart';

class AddressTextFormField extends StatelessWidget {
  final String? Function(String?) validator;
  final bool? Function(String?) onChanged;
  final String name;
  TextEditingController controllerUser = new TextEditingController();
  AddressTextFormField(
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
        prefixIcon: Icon(Icons.person_pin_circle),
        border: OutlineInputBorder(),
      ),
    );
  }
}
