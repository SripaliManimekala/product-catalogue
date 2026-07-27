import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_catalogue/provider/product_provider.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          if (provider.products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];
              return ListTile(
                leading: Image.network(
                  product.imageUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text(product.category),
                trailing: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}