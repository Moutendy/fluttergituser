import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalParams {
  static List<Map<String, dynamic>> menus = [
    // ignore: prefer_const_constructors
    {"title": "GitHub", "icon": Icon(Icons.home), "route": "/"},
    {"title": "Users GitHub", "icon": Icon(Icons.person), "route": "/users"},
    {"title": "Mp3", "icon": Icon(Icons.music_note), "route": "/mp3"},
  ];
}
