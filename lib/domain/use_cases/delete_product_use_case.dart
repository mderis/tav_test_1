import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/data/repositories/products_repository_impl.dart';
import 'package:tavtestproject1/objects/product_model.dart';

class DeleteProductUseCase extends UseCase<bool, DeleteProductUseCaseParams>{
  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<bool> call(DeleteProductUseCaseParams params) {
    return _productsRepository.delete(params.productModel);
  }

}

class DeleteProductUseCaseParams extends Equatable{
  final ProductModel productModel;

  DeleteProductUseCaseParams(this.productModel);

  @override
  List<Object> get props =>[productModel];
}