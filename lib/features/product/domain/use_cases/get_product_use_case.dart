import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';

class GetProductUseCase extends UseCase<ProductModel, Params>{

  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<ProductModel> call(Params params) {
    return _productsRepository.findById(params.id);
  }

}
class Params extends Equatable{
  final String id;

  Params(this.id);

  @override
  List<Object> get props =>[id];
}