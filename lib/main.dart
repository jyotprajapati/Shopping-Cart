import 'package:flutter/material.dart';

import 'UI/CartView.dart';
import 'UI/ProductlistView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProductListView(),
        '/cart': (context) => CartView(),
      },
    );
  }
}
