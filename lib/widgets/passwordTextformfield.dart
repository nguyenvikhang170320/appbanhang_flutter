import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obserText;
  final String? Function(String?)? validator;
  final bool? Function(String?)? onChanged;
  final String name;
  final void Function() onTap;
  const PasswordTextFormField(
      {super.key,
      required this.name,
      required this.onChanged,
      required this.obserText,
      required this.validator,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obserText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child:
              Icon(obserText == true ? Icons.visibility : Icons.visibility_off),
        ),
        hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
      ),
    );
  }
}
