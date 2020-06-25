import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';

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