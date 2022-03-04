import 'package:flutter/material.dart';

import '../menu/mydrawer.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: MyDrawer(),
      // ignore: prefer_const_constructors
      body: Center(child: Text('Home')),
    );
  }
}
