import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/data/repositories/products_repository_impl.dart';
import 'package:tavtestproject1/domain/repositories/products_repository.dart';
import 'package:tavtestproject1/objects/product_model.dart';

class EditProductUseCase extends UseCase<ProductModel, EditProductUseCaseParams>{

  ProductsRepository _productsRepository = ProductsRepositoryImpl();

  @override
  Future<ProductModel> call(EditProductUseCaseParams params) async{
    return await _productsRepository.edit(params.productModel);
  }

}

class EditProductUseCaseParams extends Equatable{
  final ProductModel productModel;

  EditProductUseCaseParams(this.productModel);

  @override
  List<Object> get props =>[productModel];
}