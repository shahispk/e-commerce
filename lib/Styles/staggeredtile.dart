import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:flutter/material.dart';

class StraggeredTile extends StatefulWidget {
  const StraggeredTile(
      {super.key,
      required this.imageURL,
      required this.name,
      required this.price});
  final String imageURL;
  final String name;
  final String price;

  @override
  State<StraggeredTile> createState() => _StraggeredTileState();
}

class _StraggeredTileState extends State<StraggeredTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(
                widget.imageURL,
              ),
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.only(top: 12),
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appstyle1(20, Colors.black, FontWeight.w700, 1),
                  ),
                  Text(
                    widget.price,
                    style: appstyle1(20, Colors.black, FontWeight.w500, 1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
