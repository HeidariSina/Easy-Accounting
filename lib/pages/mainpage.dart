import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money/pages/first.dart';
import '../components/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  String? name;
  String? theme;
  bool come = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        come = true;
      });
    });
    return come == false
        ? Container(
            decoration: const BoxDecoration(color: Colors.black),
          )
        : name != null
            ? const BottomNavBar()
            : const FirstPage();
  }
}
