import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:ecomhiveandprovider/Styles/newShoes.dart';
import 'package:ecomhiveandprovider/Styles/product_card.dart';
import 'package:ecomhiveandprovider/Styles/sneakers-model.dart';
import 'package:ecomhiveandprovider/pages/product_by_cat.dart';
import 'package:ecomhiveandprovider/pages/product_pages.dart';
import 'package:ecomhiveandprovider/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home_Widget extends StatelessWidget {
  const Home_Widget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabindex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabindex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final shoe = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              productNotifier.shoeSizes = shoe.sizes;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Product_page(
                                          id: shoe.id,
                                          category: shoe.category)));
                            },
                            child: Productcard(
                                price: "\$${shoe.price}",
                                category: shoe.category,
                                id: shoe.id,
                                name: shoe.name,
                                image: shoe.imageURL[0]),
                          );
                        });
                  }
                })),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productbycat(
                                        tabindex: tabindex,
                                      )));
                        },
                        child: Text(
                          "Show All",
                          style: appstyle(24, Colors.black, FontWeight.w500),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_right,
                        size: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.156,
            child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final shoe = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: NewShoes(
                              imageURL: shoe.imageURL[0],
                            ),
                          );
                        });
                  }
                }))
      ],
    );
  }
}
