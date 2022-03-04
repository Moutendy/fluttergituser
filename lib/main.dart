// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:git_hub_mobile_app/pagedart/homepage.dart';
import 'package:git_hub_mobile_app/pagedart/pagemp3.dart';
import 'package:git_hub_mobile_app/pagedart/userpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        "/users": (context) => UsersPage(),
        "/": (context) => HomePage(),
        "/mp3": (context) => HomeMp3(),
      },
      initialRoute: "/",
    );
  }
}
