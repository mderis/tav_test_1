import 'package:flutter/material.dart';
import 'package:tavtestproject1/features/product/presentation/screens/product_shop_details_screen.dart';
import 'package:tavtestproject1/features/product/presentation/screens/product_shop_screen.dart';
import 'package:tavtestproject1/features/settings/presentation/screens/settings_screen.dart';
import 'package:tavtestproject1/features/splash/presentation/screens/splash_screen.dart';
import 'package:tavtestproject1/features/user/presentation/screens/login_screen.dart';
import 'package:tavtestproject1/features/user/presentation/screens/profile_edit_details_screen.dart';

import 'features/product/data/models/product_model.dart';
import 'features/product/presentation/screens/product_add_screen.dart';
import 'features/product/presentation/screens/product_details_screen.dart';
import 'features/product/presentation/screens/product_list_screen.dart';
import 'features/user/presentation/screens/profile_edit_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //---------------------------------------------------------------------//
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      //---------------------------------------------------------------------//
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/profile/edit':
        return MaterialPageRoute(builder: (_) => ProfileEditScreen());
      //---------------------------------------------------------------------//
      case '/product/shop':
        return MaterialPageRoute(builder: (_) => ProductShopScreen());
      case '/product/shop/details':
        return MaterialPageRoute(builder: (_) => ProductShopDetailsScreen(args));
      case '/product/list':
        return MaterialPageRoute(builder: (_) => ProductListScreen());
      case '/product/add':
        return MaterialPageRoute(builder: (_) => ProductAddScreen.add(args));
      case '/product/edit':
        return MaterialPageRoute(builder: (_) => ProductAddScreen.edit(args));
      case '/product/details':
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen(args));
      //---------------------------------------------------------------------//
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
    }
  }
}

class ProductAddArgs {}

class ProductDetailsArgs {
  final ProductModel productModel;

  ProductDetailsArgs(this.productModel);
}

class ProductEditArgs {
  final ProductModel productModel;

  ProductEditArgs(this.productModel);
}
