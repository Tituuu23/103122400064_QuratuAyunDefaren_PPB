import 'package:flutter/material.dart';

class M5ListView extends StatelessWidget {
  const M5ListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(color : Colors.yellow[500], width: 100, child: Text("Entry A")),
        Container(color : Colors.yellow[300], width: 100, child: Text("Entry B")),
        Container(color : Colors.yellow[100], width: 100, child: Text("Entry C")),
      ],
    );
  }
}