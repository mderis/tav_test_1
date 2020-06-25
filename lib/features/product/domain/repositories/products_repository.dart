
import 'package:tavtestproject1/features/product/data/models/product_model.dart';

abstract class ProductsRepository {
  Future<ProductModel> create(ProductModel productModel);
  Future<ProductModel> findById(String id);
  Future<List<ProductModel>> getAll();
  Future<List<ProductModel>> search(String q);
  Future<bool> delete(ProductModel productModel);
  Future<ProductModel> edit(ProductModel productModel);
}
