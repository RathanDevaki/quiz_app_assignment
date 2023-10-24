import 'package:flutter/material.dart';
import 'package:quiz_app_assignment/Components/constants.dart';

PreferredSizeWidget CommonAppBar(String text) {
  return AppBar(
    backgroundColor: ThemeColor,
    elevation: 0,
    // actions: [
    //   GestureDetector(
    //       onTap: () {
    //         logOut();
    //       },
    //       child: Icon(Icons.logout, size: 12)),
    // ],
    title: Text(
      text,
      style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 255, 255, 255)),
    ),
  );
}
