import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:ecomhiveandprovider/Styles/sneakers-model.dart';
import 'package:ecomhiveandprovider/Tabbarpages/home_widget.dart';
import 'package:ecomhiveandprovider/helper.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getWomenSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    // TODO: implement initState;
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 169, 169),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.black,
                child: Container(
                  padding: EdgeInsets.only(left: 8, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Athletics Shoes",
                        style:
                            appstyle1(42, Colors.white, FontWeight.bold, 1.4),
                      ),
                      Text(
                        "Collection",
                        style:
                            appstyle1(42, Colors.white, FontWeight.bold, 1.2),
                      ),
                      TabBar(
                          padding: EdgeInsets.zero,
                          dividerColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appstyle(24, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: [
                            Tab(
                              text: "Men Shoes",
                            ),
                            Tab(
                              text: "Women Shoes",
                            ),
                            Tab(
                              text: "Kids Shoes",
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.265),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    Home_Widget(
                      male: _male,
                      tabindex: 0,
                    ),
                    Home_Widget(
                      male: _female,
                      tabindex: 1,
                    ),
                    Home_Widget(
                      male: _kids,
                      tabindex: 2,
                    ),
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
