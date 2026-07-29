import 'package:flutter/material.dart';
import 'package:product_catalogue/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductSearchField extends StatefulWidget {
  const ProductSearchField({super.key});

  @override
  State<ProductSearchField> createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  SearchBar(
        hintText: 'Search products...',
         
        leading: Icon(Icons.search),
        autoFocus: false,
        onChanged: (value) => context.read<ProductProvider>().searchProducts(value),
      
      ),
    );
  }
}