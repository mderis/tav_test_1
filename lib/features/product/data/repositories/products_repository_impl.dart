
import 'package:tavtestproject1/features/product/data/data_sources/local_data_source.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  LocalDataSource _localDataSource = LocalDataSource();

  @override
  Future<ProductModel> create(ProductModel productModel) async {
    return await _localDataSource.create(productModel);
  }

  @override
  Future<ProductModel> findById(String id) async {
    return await _localDataSource.findById(id);
  }

  @override
  Future<List<ProductModel>> getAll() async {
    return _localDataSource.getAll();
  }

  @override
  Future<List<ProductModel>> search(String q) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(ProductModel productModel) {
    return _localDataSource.delete(productModel);
  }

  @override
  Future<ProductModel> edit(ProductModel productModel) {
    return _localDataSource.edit(productModel);
  }
}
