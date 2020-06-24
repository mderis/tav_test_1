import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/data/repositories/products_repository_impl.dart';
import 'package:tavtestproject1/objects/product_model.dart';

class GetAllProductsUseCase extends UseCase<List<ProductModel>, NoParams>{

  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<List<ProductModel>> call(NoParams params) async {
    return await _productsRepository.getAll();
  }

}