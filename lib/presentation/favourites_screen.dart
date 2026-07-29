import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:product_catalogue/provider/favorites_provider.dart';
import 'package:product_catalogue/provider/product_provider.dart';
import 'package:product_catalogue/widgets/product_card.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final products = context
        .watch<ProductProvider>()
        .products
        .where((product) => favorites.isFavorite(product.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: SafeArea(
        child: products.isEmpty
            ? const Center(child: Text('No favourites yet'))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard2(
                      product: product,
                      onTap: () => context.push('/product/${product.id}'),
                    );
                  },
                ),
              ),
      ),
    );
  }
}