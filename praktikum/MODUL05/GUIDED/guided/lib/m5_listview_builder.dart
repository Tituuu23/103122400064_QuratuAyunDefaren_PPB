import 'package:flutter/material.dart';

class M5ListViewBuilder extends StatelessWidget {
  const M5ListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    List items = ["A", "B", "C"];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => Container(
        color : Colors.red[100 * ((index % 8) + 1)],
        height: 100,
        child: Text("Entry ${items[index]}"),
      ),
    );
  }
}