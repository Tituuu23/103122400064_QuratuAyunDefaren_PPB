import 'package:flutter/material.dart';

class M5Expanded extends StatelessWidget {
  const M5Expanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            color: Colors.red,
            child: const Center(child: Text("Expanded 1")),
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            color: Colors.green,
            child: const Center(child: Text("Expanded 2")),
          ),
        ),
      ]
    );
  }
}