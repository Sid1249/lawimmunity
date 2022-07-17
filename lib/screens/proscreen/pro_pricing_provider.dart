import 'package:flutter/material.dart';

class ProPricingProvider extends ChangeNotifier{

  double _price = 2100;

  double get price => _price;

  set price(double value) {
    _price = value;
  }


  bool isPro = false;


}