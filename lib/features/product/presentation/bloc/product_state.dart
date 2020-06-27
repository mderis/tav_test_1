import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductListEmptyState extends ProductState {
}

class ProductListLoadingState extends ProductState {
}

class ProductListLoadedState extends ProductState {
  final List<ProductModel> productList;

  ProductListLoadedState(this.productList);

  @override
  List<Object> get props => [productList];
}