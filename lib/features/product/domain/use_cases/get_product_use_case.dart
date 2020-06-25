import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';

class GetProductUseCase extends UseCase<ProductModel, GetProductUseCaseParams>{

  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<ProductModel> call(GetProductUseCaseParams params) {
    return _productsRepository.findById(params.id);
  }

}
class GetProductUseCaseParams extends Equatable{
  final String id;

  GetProductUseCaseParams(this.id);

  @override
  List<Object> get props =>[id];
}