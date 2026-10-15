import 'package:flutter/material.dart';

class M5GridViewCount extends StatelessWidget {
  const M5GridViewCount({super.key});

  @override
  Widget build(BuildContext context) {
    List items = ["A", "B", "C"];

    return GridView.count(
      crossAxisCount: 2,
      children: [
        for (int i = 0; i < items.length; i++) 
        Container(
          color: Colors.blue[100 * ((i % 8) + 1)],
          child: Text("${items[i]}")
        )
      ]
    );
  }
}