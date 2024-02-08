import 'package:ecomhiveandprovider/Styles/bottomnav.dart';
import 'package:ecomhiveandprovider/providers/mainscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Consumer<MainScreenNotifier>(
        builder: (context, mainscreennotifier, child) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          padding: EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNav(
                onTap: () {
                  mainscreennotifier.pageIndex = 0;
                },
                icon: mainscreennotifier.pageIndex == 0
                    ? Icons.home
                    : Icons.home_outlined,
              ),
              BottomNav(
                onTap: () {
                  mainscreennotifier.pageIndex = 1;
                },
                icon: mainscreennotifier.pageIndex == 1
                    ? Icons.search
                    : Icons.search_outlined,
              ),
              BottomNav(
                onTap: () {
                  mainscreennotifier.pageIndex = 2;
                },
                icon: mainscreennotifier.pageIndex == 2
                    ? Icons.add
                    : Icons.add_outlined,
              ),
              BottomNav(
                onTap: () {
                  mainscreennotifier.pageIndex = 3;
                },
                icon: mainscreennotifier.pageIndex == 3
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
              ),
              BottomNav(
                onTap: () {
                  mainscreennotifier.pageIndex = 4;
                },
                icon: mainscreennotifier.pageIndex == 4
                    ? Icons.person
                    : Icons.person_outlined,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
