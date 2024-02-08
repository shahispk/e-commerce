import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "search",
        style: appstyle(36, Colors.black, FontWeight.bold),
      ),
    );;
  }
}