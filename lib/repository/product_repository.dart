
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_catalogue/models/product.dart';

class ProductRepository {
  static const String _baseUrl = 'https://dummyjson.com';
  
 /// Talks to the dummyjson.com REST API

  Future<List<Product>> getProducts() async {
    try {
      final res = await http.get(Uri.parse('$_baseUrl/products'));
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 200) {
        throw body['message'] ?? 'Validation failed';
      }
      final List<dynamic> productsJson = body['products'] as List<dynamic>;
      return productsJson.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      throw 'Failed to fetch products';
    }
  }

  
}
