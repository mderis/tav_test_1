import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/objects/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class AddProductEvent extends ProductEvent {
  final ProductModel productModel;

  AddProductEvent(this.productModel);

  @override
  List<Object> get props => [];
}

class DeleteProductEvent extends ProductEvent {
  final ProductModel productModel;

  DeleteProductEvent(this.productModel);

  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}
