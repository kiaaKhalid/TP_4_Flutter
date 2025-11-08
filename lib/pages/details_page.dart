import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stock_provider.dart';

class DetailsPage extends StatelessWidget {
  final String productId;

  const DetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductsProvider>().getProductById(productId);
    final cart = context.watch<CartProvider>();
    final favorites = context.watch<FavoritesProvider>();
    final stockProvider = context.read<StockProvider>();

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Détails')),
        body: const Center(child: Text('Produit non trouvé')),
      );
    }

    final isFavorite = favorites.isFavorite(product);
    final isInCart = cart.isInCart(product);
    final quantity = cart.getQuantity(product);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              context.read<FavoritesProvider>().toggle(product);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                child: Text(
                  product.imageUrl,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${product.price.toStringAsFixed(2)} €',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock disponible',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '${product.stock}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: product.stock > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle, size: 40),
                  onPressed: () {
                    stockProvider.decrement(product);
                  },
                  color: Colors.red,
                ),
                const SizedBox(width: 24),
                IconButton(
                  icon: const Icon(Icons.add_circle, size: 40),
                  onPressed: () {
                    stockProvider.increment(product);
                  },
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (isInCart) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quantité dans le panier: $quantity',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: product.stock > 0
                    ? () {
                        context.read<CartProvider>().add(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} ajouté au panier'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.shopping_cart),
                label: Text(product.stock > 0
                    ? 'Ajouter au panier'
                    : 'Rupture de stock'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

