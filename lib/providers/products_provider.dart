import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Laptop',
      description: 'Ordinateur portable haute performance',
      price: 999.99,
      imageUrl: '💻',
      stock: 15,
    ),
    Product(
      id: '2',
      name: 'Smartphone',
      description: 'Téléphone intelligent dernière génération',
      price: 599.99,
      imageUrl: '📱',
      stock: 20,
    ),
    Product(
      id: '3',
      name: 'Écouteurs',
      description: 'Écouteurs sans fil avec réduction de bruit',
      price: 199.99,
      imageUrl: '🎧',
      stock: 30,
    ),
    Product(
      id: '4',
      name: 'Montre connectée',
      description: 'Montre intelligente avec suivi de santé',
      price: 299.99,
      imageUrl: '⌚',
      stock: 12,
    ),
    Product(
      id: '5',
      name: 'Tablette',
      description: 'Tablette tactile 10 pouces',
      price: 399.99,
      imageUrl: '📱',
      stock: 8,
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}

