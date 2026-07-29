import 'package:flutter/material.dart';
import 'package:product_catalogue/models/product.dart';
import 'package:product_catalogue/repository/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  // The stable, fully-fetched set of products. Never mutated by search —
  // this is what favourites and product lookups must resolve against, so
  // a product found via search but not currently displayed doesn't vanish
  // from favourites once the search is cleared.
  List<Product> _allProducts = [];
  List<Product> get allProducts => _allProducts;

  // The filtered view shown by the product grid; derived from
  // _allProducts by searchProducts, defaults to the full list.
  List<Product> _displayedProducts = [];
  List<Product> get products => _displayedProducts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  ProductProvider(this._repository);

  Product? getById(String id) {
    for (final product in _allProducts) {
      if (product.id == id) return product;
    }
    return null;
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allProducts = await _repository.getProducts();
      _displayedProducts = _allProducts;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _displayedProducts = _allProducts;
    } else {
      final lowerQuery = query.toLowerCase();
      _displayedProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(lowerQuery) ||
              product.category.toLowerCase().contains(lowerQuery))
          .toList();
    }
    notifyListeners();
  }
}