import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';

class GetAllProductsUseCase extends UseCase<List<ProductModel>, NoParams>{

  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<List<ProductModel>> call(NoParams params) async {
    return await _productsRepository.getAll();
  }

}