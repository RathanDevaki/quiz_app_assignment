import 'package:flutter/material.dart';
import 'package:quiz_app_assignment/Components/constants.dart';

PreferredSizeWidget CommonAppBar(String text) {
  return AppBar(
    backgroundColor: ThemeColor,
    elevation: 0,
    title: Text(
      text,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 255, 255, 255)),
    ),
  );
}
