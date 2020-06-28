import 'package:tavtestproject1/features/user/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> create(UserModel userModel);

  Future<UserModel> get();

  Future<UserModel> edit(UserModel userModel);
}
