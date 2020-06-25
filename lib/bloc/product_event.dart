import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/objects/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class AddProductEvent extends ProductEvent {
  final ProductModel productModel;

  AddProductEvent(this.productModel);

  @override
  List<Object> get props => [productModel];
}

class DeleteProductEvent extends ProductEvent {
  final ProductModel productModel;

  DeleteProductEvent(this.productModel);

  @override
  List<Object> get props => [productModel];
}

class EditProductEvent extends ProductEvent {
  final ProductModel productModel;

  EditProductEvent(this.productModel);

  @override
  List<Object> get props => [productModel];
}

class GetProductEvent extends ProductEvent{
  final String id;

  GetProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetAllProductsEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}
