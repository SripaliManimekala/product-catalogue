import 'package:flutter/material.dart';
import 'package:product_catalogue/models/product.dart';
import 'package:product_catalogue/provider/favorites_provider.dart';
import 'package:product_catalogue/widgets/product_image.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();

    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductImage(
              imagePath: product.imageUrl,
              isFavorite: favorites.isFavorite(product.id),
              onFavoriteToggle: () =>
                  context.read<FavoritesProvider>().toggle(product.id),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 24, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.category,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryFixed)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}