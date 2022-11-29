// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final IconData icon;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: Color(0xff356cfb),
      cursorWidth: 2.0,
      cursorHeight: 29.0,
      cursorRadius: Radius.circular(1),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        hintStyle: TextStyle(
          color: Color(0xff656580),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        border: InputBorder.none,
      ),
      obscureText: isObscure,
    );
  }
}
