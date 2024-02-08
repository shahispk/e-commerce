import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class Cartpage extends StatelessWidget {
  Cartpage({super.key});
  final _cartBox = Hive.box('cart_box');
  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageURL": item['imageURL'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(12),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              Text(
                "My Cart",
                style: appstyle(36, Colors.black, FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Slidable(
                              key: ValueKey(0),
                              endActionPane: const ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 1,
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: "Delete",
                                      onPressed: null,
                                    )
                                  ]),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: Offset(0, 1))
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Image.asset(
                                        data['imageURL'],
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                          data['name'],
                                            style: appstyle(16, Colors.black,
                                                FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      ),
    ));
  }
}
