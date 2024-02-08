import 'package:ecomhiveandprovider/Styles/bottomnavbarwidget.dart';
import 'package:ecomhiveandprovider/pages/cartpage.dart';
import 'package:ecomhiveandprovider/pages/homepage.dart';
import 'package:ecomhiveandprovider/pages/profile.dart';
import 'package:ecomhiveandprovider/pages/searchpage.dart';
import 'package:ecomhiveandprovider/providers/mainscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList =  [
    Homepage(),
    Searchpage(),
    Homepage(),
    Cartpage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainscreennotifier, child) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 169, 169),
        body: pageList[mainscreennotifier.pageIndex],
        bottomNavigationBar: const Bottomnavbar(),
      );
    });
  }
}
