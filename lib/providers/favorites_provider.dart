import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Product product) {
    return _favorites.any((item) => item.id == product.id);
  }

  void toggle(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  void remove(Product product) {
    _favorites.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
}

