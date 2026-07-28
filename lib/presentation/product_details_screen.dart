import 'package:flutter/material.dart';
import 'package:product_catalogue/widgets/product_image.dart';
import 'package:provider/provider.dart';
import 'package:product_catalogue/provider/product_provider.dart';
import 'package:product_catalogue/provider/favorites_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>().getById(id);

    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Column(
            
                    children: [
                      Text(
                        product!.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            
                      ProductImage(
                        imagePath: product.imageUrl,
                        isFavorite: favorites.isFavorite(product.id),
                        onFavoriteToggle:
                            () => context.read<FavoritesProvider>().toggle(
                              product.id,
                            ),
                      ),
                      const SizedBox(height: 20),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.bold, ),),
                                 
                        Text(product.description,textAlign: TextAlign.justify,),
                     ],),
                   )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
