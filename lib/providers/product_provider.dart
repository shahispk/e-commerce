import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoesSizes = [];
  List<String> _sizes = [];
  int get activepage => _activepage;
  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoesSizes;
  set shoeSizes(List<dynamic> newSizes) {
    _shoesSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoesSizes.length; i++) {
      if (i == index) {
        _shoesSizes[i]['isSelected'] = !_shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;
  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }
}
