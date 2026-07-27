import 'package:flutter/material.dart';
import 'package:product_catalogue/models/product.dart';
import 'package:product_catalogue/repository/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  ProductProvider(this._repository);

  Product? getById(String id) {
    for (final product in _products) {
      if (product.id == id) return product;
    }
    return null;
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _repository.getProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}