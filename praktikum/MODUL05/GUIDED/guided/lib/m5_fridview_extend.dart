
import 'package:flutter/material.dart';

class M5GridViewExtend extends StatelessWidget {
  const M5GridViewExtend({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ["A", "B", "C", "D", "E", "F"];

    return GridView.extent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        for (int index = 0; index < items.length; index++)
          Container(
            color: Colors.green[100 * ((index % 8) + 1)],
            alignment: Alignment.center,
            child: Text(items[index]),
          ),
      ],
    );
  }
}
