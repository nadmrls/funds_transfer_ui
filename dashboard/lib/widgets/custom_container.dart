import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color background;
  const CustomContainer({super.key, required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(15)),
      child: const Column(
        children: [Text('data'), Divider(), Text('data')],
      ),
    );
  }
}
