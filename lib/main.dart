import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_catalogue/presentation/product_list_screen.dart';
import 'package:product_catalogue/provider/product_provider.dart';
import 'package:product_catalogue/repository/product_repository.dart';
import 'package:product_catalogue/utils/app_theme.dart';
import 'package:product_catalogue/utils/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider(ProductRepository())),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Product Catalogue',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const ProductsListScreen(),
          );
        },
      ),
    );
  }
}
