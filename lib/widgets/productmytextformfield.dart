import 'package:flutter/material.dart';

class ProductMyTextFormField extends StatelessWidget {
  final String name;
  final bool? Function(String?) onChanged;
  ProductMyTextFormField({
    super.key,
    required this.name,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: name,
        hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
      ),
    );
  }
}
