import 'package:flutter/material.dart';
import '../models/product.dart';

class StockProvider with ChangeNotifier {
  void increment(Product product) {
    product.stock++;
    notifyListeners();
  }

  void decrement(Product product) {
    if (product.stock > 0) {
      product.stock--;
      notifyListeners();
    }
  }

  void updateStock(Product product, int newStock) {
    if (newStock >= 0) {
      product.stock = newStock;
      notifyListeners();
    }
  }
}

