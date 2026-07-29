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
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ProductImage(
                imagePath: product.imageUrl,
                isFavorite: favorites.isFavorite(product.id),
                onFavoriteToggle: () =>
                    context.read<FavoritesProvider>().toggle(product.id),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 24, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                         style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                        style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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


class ProductCard2 extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard2({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 56,
            height: 56,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
             errorBuilder: (context, error, stackTrace) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
        ),
        title: Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                         style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                        style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                        ),
                      ),
                    ],
                  ),
        trailing: IconButton(
          icon: Icon(
            favorites.isFavorite(product.id)
                ? Icons.favorite
                : Icons.favorite_border,
            color: theme.colorScheme.primary,
          ),
          onPressed: () =>
              context.read<FavoritesProvider>().toggle(product.id),
        ),
      ),
    );
  }
}