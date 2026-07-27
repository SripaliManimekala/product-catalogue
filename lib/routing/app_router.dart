import 'package:go_router/go_router.dart';
import 'package:product_catalogue/presentation/product_details_screen.dart';
import 'package:product_catalogue/presentation/product_list_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) =>
          ProductDetailsScreen(id: state.pathParameters['id']!),
    ),
  ],
);
