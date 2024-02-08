import 'package:ecomhiveandprovider/Styles/LatestShoes..dart';
import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:ecomhiveandprovider/Styles/categoryBin.dart';
import 'package:ecomhiveandprovider/Styles/sneakers-model.dart';
import 'package:ecomhiveandprovider/Styles/spacer.dart';
import 'package:ecomhiveandprovider/helper.dart';
import 'package:flutter/material.dart';

class Productbycat extends StatefulWidget {
  const Productbycat({super.key, required this.tabindex});
  final int tabindex;
  @override
  State<Productbycat> createState() => _ProductbycatState();
}

class _ProductbycatState extends State<Productbycat>
    with TickerProviderStateMixin {
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

  List<String> brand = [
    "images/adidas.png",
    "images/nike.png",
    "images/puma.png",
    "images/newbalance.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 179, 169, 169),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(255, 74, 73, 68),
            ),
            color: const Color.fromARGB(255, 74, 73, 68),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  filter();
                },
                icon: const Icon(
                  Icons.filter,
                  color: Color.fromARGB(255, 74, 73, 68),
                )),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: TabBar(
                
                padding: EdgeInsets.only(bottom: 15),
                dividerColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                unselectedLabelColor: Colors.grey.withOpacity(0.3),
                tabs: const [
                  Text("Men Shoes"),
                  Text("Women Shoes"),
                  Text("Kids Shoes"),
                ],
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: TabBarView(
            controller: _tabController,
            children: [
              Latestshoes(male: _male,
              
              ),
              Latestshoes(male: _female),
              Latestshoes(male: _kids),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black38),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        const CustomSpacer(),
                        Text(
                          "Filter",
                          style: appstyle(40, Colors.black, FontWeight.bold),
                        ),
                        const CustomSpacer(),
                        Text(
                          "Gender",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CategoryBin(
                                onpress: () => (),
                                label: "Men",
                                buttoncolor: Colors.black),
                            CategoryBin(
                                onpress: () => (),
                                label: "Women",
                                buttoncolor: Colors.grey),
                            CategoryBin(
                                onpress: () => (),
                                label: "Kids",
                                buttoncolor: Colors.grey),
                          ],
                        ),
                        const CustomSpacer(),
                        Text(
                          "Category",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        CustomSpacer(),
                        Row(
                          children: [
                            CategoryBin(
                                onpress: () => (),
                                label: "Shoes",
                                buttoncolor: Colors.black),
                            CategoryBin(
                                onpress: () => (),
                                label: "Apparrels",
                                buttoncolor: Colors.grey),
                            CategoryBin(
                                onpress: () => (),
                                label: "Accessories",
                                buttoncolor: Colors.grey),
                          ],
                        ),
                        CustomSpacer(),
                        Text(
                          "Price",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        CustomSpacer(),
                        Slider(
                            value: _value,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.black,
                            max: 500,
                            divisions: 50,
                            label: _value.toString(),
                            secondaryTrackValue: 200,
                            onChanged: (double value) {}),
                        CustomSpacer(),
                        Text(
                          "Brands",
                          style: appstyle(20, Colors.black, FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 80,
                          child: ListView.builder(
                              itemCount: brand.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.shade200),
                                    child: Image.asset(
                                      brand[index],
                                      height: 60,
                                      width: 80,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
