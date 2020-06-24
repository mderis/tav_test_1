import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/data/repositories/products_repository_impl.dart';
import 'package:tavtestproject1/objects/product_model.dart';

class GetProductUseCase extends UseCase<ProductModel, Params>{

  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<ProductModel> call(Params params) {
    return _productsRepository.findById(params.id);
  }

}
class Params extends Equatable{
  final int id;

  Params(this.id);

  @override
  List<Object> get props =>[id];
}