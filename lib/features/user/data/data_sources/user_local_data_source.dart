import 'package:sembast/sembast.dart';
import 'package:tavtestproject1/core/database/app_database.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';

class UserLocaleDataSource {
  Future<Database> get _db async => await AppDatabase.instance.database;

  var _store = intMapStoreFactory.store('users');

  Future<UserModel> get() async {
    Finder finder = Finder();
    var snapshot = await _store.find(await _db, finder: finder);
    if (snapshot.length == 0){
      return null;
    }
    else{
      UserModel userModel = UserModel.fromJson(snapshot[0].value);
      return userModel;
    }
  }

  Future<UserModel> create(UserModel userModel) async {
    await _store.add(await _db, userModel.toJson());
    return userModel;
  }

  Future<UserModel> edit(UserModel userModel) async {
    Finder finder = Finder();
    await _store.update(await _db, userModel.toJson(), finder: finder);
    return userModel;
  }
}
