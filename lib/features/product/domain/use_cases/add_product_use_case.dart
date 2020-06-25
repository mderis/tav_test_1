import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/data/repositories/products_repository_impl.dart';

class AddProductUseCase extends UseCase<ProductModel, AddProductUseCaseParams> {
  final _productsRepository = ProductsRepositoryImpl();

  @override
  Future<ProductModel> call(AddProductUseCaseParams params) async {
    return await _productsRepository.create(params.productModel);
  }
}

class AddProductUseCaseParams extends Equatable {
  final ProductModel productModel;

  AddProductUseCaseParams(this.productModel);

  @override
  List<Object> get props => [productModel];
}
