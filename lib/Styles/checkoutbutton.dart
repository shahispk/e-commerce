import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:flutter/material.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key, this.onTap, required this.label,
  });
  final void Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: MediaQuery.of(context).size.height * 0.9,
          child: Center(
            child: Text(
              label,
              style: appstyle(20, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
