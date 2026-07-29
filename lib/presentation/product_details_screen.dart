import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:product_catalogue/provider/favorites_provider.dart';
import 'package:product_catalogue/provider/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>().getById(id);
    final theme = Theme.of(context);

    if (product == null) {
      // Defensive fallback — should not normally happen since navigation
      // only occurs from an already-loaded product list.
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Product not found.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 340,
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.onSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-image-${product.id}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(
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
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, _) {
                      final isFavorite = favoritesProvider.isFavorite(product.id);
                      final icon = Icon(
                        isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                      );
                      final label = Text(
                        isFavorite ? 'Remove from Favourites' : 'Add to Favourites',
                      );
                      return SizedBox(
                        width: double.infinity,
                        child: isFavorite
                            ? OutlinedButton.icon(
                                onPressed: () => favoritesProvider.toggle(product.id),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: theme.colorScheme.primary,
                                  side: BorderSide(color: theme.colorScheme.primary),
                                ),
                                icon: icon,
                                label: label,
                              )
                            : ElevatedButton.icon(
                                onPressed: () => favoritesProvider.toggle(product.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                ),
                                icon: icon,
                                label: label,
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
