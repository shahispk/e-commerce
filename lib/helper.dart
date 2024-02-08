import 'package:ecomhiveandprovider/Styles/sneakers-model.dart';
import 'package:flutter/services.dart' as the_bundle;

class Helper {
  //Male
  Future<List<Sneakers>> getMaleSneakers() async {
    final data = await the_bundle.rootBundle.loadString("json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    return maleList;
  }
//Female
  Future<List<Sneakers>> getWomenSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("json/women-shoes.json");
    final womenList = sneakersFromJson(data);
    return womenList;
  }
//Kids
  Future<List<Sneakers>> getKidsSneakers() async {
    final data = await the_bundle.rootBundle.loadString("json/kids-shoes.json");
    final kidsList = sneakersFromJson(data);
    return kidsList;
  }
//Single male
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("json/men-shoes.json");
    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
  //Single female
  Future<Sneakers> getWomenSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("json/women-shoes.json");
    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
  //Single Kid
  Future<Sneakers> getKidsSneakersById(String id) async {
    final data = await the_bundle.rootBundle.loadString("json/kids-shoes.json");
    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
