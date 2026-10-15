import 'package:flutter/material.dart';

class M5GridViewBuilder extends StatelessWidget {
  const M5GridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
  List items = ["A", "B", "C"];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ), 
      itemCount: items.length,
      itemBuilder: (context, index) => Container(
        color : Colors.green[100 * ((index % 8) + 1)], 
        child: Center(
          child: Text(items[index]),
        ),
      ),
    );
  }
}