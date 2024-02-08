import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "profile",
        style: appstyle(36, Colors.black, FontWeight.bold),
      ),
    );
    ;
  }
}
