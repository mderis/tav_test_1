import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/objects/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductListEmptyState extends ProductState{

  @override
  List<Object> get props => [];

}

class ProductListLoadingState extends ProductState{

  @override
  List<Object> get props => [];

}

class ProductListLoadedState extends ProductState{

  final List<ProductModel> productList;


  ProductListLoadedState(this.productList);

  @override
  List<Object> get props => [productList];

}