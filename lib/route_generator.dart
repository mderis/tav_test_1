import 'package:flutter/material.dart';
import 'features/product/data/models/product_model.dart';
import 'features/product/presentation/screens/add_screen.dart';
import 'features/product/presentation/screens/main_screen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> MainScreen());
      case '/add-product':
        return MaterialPageRoute(builder: (_)=> AddScreen.add(args));
      case '/edit-product':
        return MaterialPageRoute(builder: (_)=> AddScreen.edit(args));
    }
  }
}

class AddArgs{

}

class EditArgs{
  final ProductModel productModel;

  EditArgs(this.productModel);
}
