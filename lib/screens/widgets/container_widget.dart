import 'package:flutter/material.dart';

Widget customContainer({required Widget child}) {
  return Container(
    width: 321,
    height: 65,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32.50),
      color: const Color(0xfff8f7ff),
    ),
    child: Center(child: child),
  );
}
