import 'package:flutter/material.dart';
import 'features/product/data/models/product_model.dart';
import 'features/product/presentation/screens/product_add_screen.dart';
import 'features/product/presentation/screens/product_list_screen.dart';
import 'features/product/presentation/screens/product_details_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ProductListScreen());
      case '/product/add':
        return MaterialPageRoute(builder: (_) => ProductAddScreen.add(args));
      case '/product/edit':
        return MaterialPageRoute(builder: (_) => ProductAddScreen.edit(args));
      case '/product/details':
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen(args));
    }
  }
}

class ProductAddArgs {}

class ProductDetailsArgs {
  final String id;

  ProductDetailsArgs(this.id);
}

class ProductEditArgs {
  final ProductModel productModel;

  ProductEditArgs(this.productModel);
}
