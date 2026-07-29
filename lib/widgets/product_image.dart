import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imagePath,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  final String imagePath;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.broken_image));
              },
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (onFavoriteToggle != null)
          Positioned(
            right: 12,
            bottom: -16,
            child: _FavoriteBadge(
              isFavorite: isFavorite,
              onTap: onFavoriteToggle!,
            ),
          ),
      ],
    );
  }
}

class _FavoriteBadge extends StatelessWidget {
  const _FavoriteBadge({required this.isFavorite, required this.onTap});

  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}