import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_catalogue/widgets/product_card.dart';
import 'package:product_catalogue/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:product_catalogue/provider/product_provider.dart';
import 'package:product_catalogue/utils/theme_provider.dart';

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
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              context
                  .read<ThemeProvider>()
                  .setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.favorite_border, size: 30),
              onPressed: () => context.push('/favourites'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ProductSearchField(),
              ),
              Expanded(
                child: Consumer<ProductProvider>(
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
          
                    return RefreshIndicator(
                      onRefresh: () => context.read<ProductProvider>().fetchProducts(),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return ProductCard(
                            product: product,
                            onTap: () => context.push('/product/${product.id}'),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          
          ),
        ),
      ),
    );
  }
}