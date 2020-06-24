import 'package:sembast/sembast.dart';
import 'package:tavtestproject1/core/database/app_database.dart';
import 'package:tavtestproject1/objects/product_model.dart';

class LocalDataSource {
  Future<Database> get _db async => await AppDatabase.instance.database;

  var _store = intMapStoreFactory.store('products');

  Future<ProductModel> findById(int id) async {
    Finder finder = Finder(filter: Filter.byKey(id));

    final snapshot = await _store.findFirst(await _db, finder: finder);

    var json = snapshot.value;
    if (json != null)
      return ProductModel.fromJson(json);
    else
      return null;
  }

  Future<ProductModel> create(ProductModel productModel) async {
    var jsonProduct = productModel.toJson();

    int id = await _store.add(await _db, jsonProduct);
    return productModel..id = id;
  }

  Future<List<ProductModel>> getAll() async {
    Finder finder = Finder();

    final snapshot = await _store.find(await _db, finder: finder);

    final productList =
        snapshot.map((e) => ProductModel.fromJson(e.value)).toList();

    return productList;
  }
}
