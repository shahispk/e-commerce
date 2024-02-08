import 'package:ecomhiveandprovider/Styles/sneakers-model.dart';
import 'package:ecomhiveandprovider/Styles/staggeredtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Latestshoes extends StatelessWidget {
  const Latestshoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              itemCount: male!.length,
              scrollDirection: Axis.vertical,
              staggeredTileBuilder: (int index) {
                return StaggeredTile.extent(
                    (index % 2 == 0) ? 1 : 1,
                    (index % 4 == 1 || index % 4 == 3)
                        ? MediaQuery.of(context).size.height * 0.35
                        : MediaQuery.of(context).size.height * 0.3);
              },
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];
                return StraggeredTile(
                  imageURL: shoe.imageURL[0],
                  name: shoe.name,
                  price: "\$${shoe.price}",
                );
              },
            );
          }
        });
  }
}
