import 'package:ecomhiveandprovider/Styles/appstyle.dart';
import 'package:ecomhiveandprovider/Styles/checkoutbutton.dart';
import 'package:ecomhiveandprovider/Styles/sneakers-model.dart';
import 'package:ecomhiveandprovider/helper.dart';
import 'package:ecomhiveandprovider/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Product_page extends StatefulWidget {
  const Product_page({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<Product_page> createState() => _Product_pageState();
}

class _Product_pageState extends State<Product_page> {
  final _cartBox = Hive.box('cart_box');
  final PageController pageController = PageController();

  late Future<Sneakers> _sneakers;
  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneakers = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's party wear") {
      _sneakers = Helper().getWomenSneakersById(widget.id);
    } else {
      _sneakers = Helper().getKidsSneakersById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: _sneakers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneakers = snapshot.data;
                return Consumer<ProductNotifier>(
                    builder: (context, productNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  productNotifier.shoeSizes.clear();
                                },
                                child: const Icon(Icons.close),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Ionicons.ellipsis_horizontal),
                              )
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sneakers!.imageURL.length,
                                    controller: pageController,
                                    onPageChanged: (page) {
                                      productNotifier.activePage = page;
                                    },
                                    itemBuilder: (context, int index) {
                                      return Stack(
                                        children: [
                                          Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.39,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.grey.shade300,
                                              child: Image.asset(
                                                sneakers.imageURL[index],
                                                fit: BoxFit.contain,
                                              )),
                                          Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              right: 20,
                                              child: const Icon(Icons.favorite,
                                                  color: Colors.grey)),
                                          Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List<Widget>.generate(
                                                    sneakers.imageURL.length,
                                                    (index) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: CircleAvatar(
                                                            radius: 5,
                                                            backgroundColor:
                                                                productNotifier
                                                                            .activepage !=
                                                                        index
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        )),
                                              )),
                                        ],
                                      );
                                    },
                                  )),
                              Positioned(
                                  bottom: 30,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.645,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sneakers.name,
                                              style: appstyle(40, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(sneakers.category),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                RatingBar.builder(
                                                    initialRating: 4,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 22,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 1),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                          Icons.star,
                                                          size: 18,
                                                          color: Colors.black,
                                                        ),
                                                    onRatingUpdate:
                                                        (rating) {}),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${sneakers.price}",
                                                  style: appstyle(
                                                      26,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Colors",
                                                      style: appstyle(
                                                          18,
                                                          Colors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.black,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Select size",
                                                      style: appstyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Text(
                                                        "View size guide",
                                                        style: appstyle(
                                                            20,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                      itemCount: productNotifier
                                                          .shoeSizes.length,
                                                      padding: EdgeInsets.zero,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final sizes =
                                                            productNotifier
                                                                    .shoeSizes[
                                                                index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: ChoiceChip(
                                                            label: Text(
                                                              sizes['size'],
                                                              style: appstyle(
                                                                  18,
                                                                  sizes['isSelected']
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            selected: sizes[
                                                                'isSelected'],
                                                            onSelected:
                                                                (newState) {
                                                              if (productNotifier
                                                                  .sizes
                                                                  .contains(sizes[
                                                                      'size'])) {
                                                                productNotifier
                                                                    .sizes
                                                                    .remove(sizes[
                                                                        'size']);
                                                              } else {
                                                                productNotifier
                                                                    .sizes
                                                                    .add(sizes[
                                                                        'size']);
                                                              }
                                                              print(
                                                                  productNotifier
                                                                      .sizes);
                                                              productNotifier
                                                                  .toggleCheck(
                                                                      index);
                                                            },
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60)),
                                                            side: const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            disabledColor:
                                                                Colors.white,
                                                            selectedColor:
                                                                Colors.black,
                                                            checkmarkColor:
                                                                Colors.white,
                                                          ),
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                sneakers.title,
                                                style: appstyle(
                                                    25,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              sneakers.description,
                                              textAlign: TextAlign.justify,
                                              maxLines: 4,
                                              style: appstyle(14, Colors.black,
                                                  FontWeight.normal),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12),
                                                child: CheckOutButton(
                                                    onTap: () async {
                                                      _createCart({
                                                        "id": sneakers.id,
                                                        "name": sneakers.name,
                                                        "category":
                                                            sneakers.category,
                                                        "sizes": productNotifier
                                                            .sizes,
                                                        "imageURL": sneakers
                                                            .imageURL[0],
                                                        "price": sneakers.price,
                                                        "qty": 1
                                                      });
                                                      productNotifier.sizes
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                    label: 'Add to cart'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
              }
            }));
  }
}
