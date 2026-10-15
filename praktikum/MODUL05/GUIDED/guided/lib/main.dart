import 'package:flutter/material.dart';
import 'package:guided/m5_gridview_count.dart';
import 'package:guided/m5_gridview_builder.dart';
import 'package:guided/m5_fridview_extend.dart';
import 'package:guided/m5_listview.dart';  
import 'package:guided/m5_listview_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: SafeArea(child: M5ListViewBuilder())),
    );
  }
}
