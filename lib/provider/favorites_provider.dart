import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesProvider extends ChangeNotifier {
  
  static const _prefsKey = 'favorite_product_ids';

  final Set<String> _favoriteIds = {};

  bool isFavorite(String productId) => _favoriteIds.contains(productId);
  
  FavoritesProvider() {
    _loadFavorites();
  }
  Future<void> toggle(String productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    await _saveFavorites();

  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ids = prefs.getStringList(_prefsKey) ?? [];
      _favoriteIds.clear();
      _favoriteIds.addAll(ids);
    } catch (_) {
      _favoriteIds.clear();
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _favoriteIds.toList());
  }
  
}
