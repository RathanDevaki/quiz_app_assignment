import 'package:flutter/material.dart';

ColorScheme myColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF123456),
  brightness: Brightness.light,
);

void showSnackBar(BuildContext context, String text) {
  text ??= 'Error Occured';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
    ),
  );
}

var ThemeColor = const Color.fromARGB(255, 34, 5, 138);
Color myColor = const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9);
