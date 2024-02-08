import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:flutter/material.dart';

class CategoryBin extends StatelessWidget {
  const CategoryBin(
      {super.key,
      this.onpress,
      required this.label,
      required this.buttoncolor});
  final void Function()? onpress;
  final String label;
  final Color buttoncolor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: buttoncolor, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            label,
            style: appstyle(20, buttoncolor, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
