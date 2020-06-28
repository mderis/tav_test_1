import 'package:tavtestproject1/features/user/data/data_sources/user_local_data_source.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserLocaleDataSource _userLocaleDataSource = UserLocaleDataSource();

  @override
  Future<UserModel> create(UserModel userModel) {
    return _userLocaleDataSource.create(userModel);
  }

  @override
  Future<UserModel> edit(UserModel userModel) {
    return _userLocaleDataSource.edit(userModel);
  }

  @override
  Future<UserModel> get() {
    return _userLocaleDataSource.get();
  }
}
