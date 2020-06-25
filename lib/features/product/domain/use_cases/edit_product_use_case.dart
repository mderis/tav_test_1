import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';
import 'package:tavtestproject1/features/product/domain/repositories/products_repository.dart';

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