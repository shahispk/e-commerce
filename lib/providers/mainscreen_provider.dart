import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex; //to retrive the value of the _pageIndex
  set pageIndex(int newIndex) {
    //set method is to a value to the pageindex
    _pageIndex = newIndex;
    notifyListeners();
  }
}
