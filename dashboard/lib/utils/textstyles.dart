import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle custom_container_title =
      TextStyle(fontFamily: 'Arial', fontSize: 15, color: Colors.white);

  static const TextStyle custom_container_data = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 0, 0));
  static const TextStyle custom_container_comment = TextStyle(
      fontStyle: FontStyle.italic,
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 10);
  static const TextStyle custom_container_date = TextStyle(
      fontStyle: FontStyle.normal,
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 12);
}
