import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_catalogue/provider/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>().getById(id);



    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('Details of product'),)],
        ),
      ),
    );
  }
}
