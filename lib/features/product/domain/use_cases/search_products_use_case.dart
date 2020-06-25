import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';

class SearchProductsUseCase extends UseCase<List<ProductModel>, SearchProductsUseCaseParams>{
  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<List<ProductModel>> call(SearchProductsUseCaseParams params)async {
    await Future.delayed(Duration(seconds: 1));
    return _productsRepository.search(params.q);
  }

}

class SearchProductsUseCaseParams extends Equatable{
  final String q;

  SearchProductsUseCaseParams(this.q);

  @override
  List<Object> get props => [q];
}