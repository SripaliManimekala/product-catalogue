import 'package:flutter/material.dart';
import 'package:product_catalogue/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.network(
        product.imageUrl,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
      title: Text(product.name),
      subtitle: Text(product.category),
      trailing: Text('\$${product.price.toStringAsFixed(2)}'),
    );
  }
}