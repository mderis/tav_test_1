import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/data/repositories/user_repository_impl.dart';
import 'package:tavtestproject1/features/user/domain/repositories/user_repository.dart';

class GetUserUseCase extends UseCase<UserModel, NoParams> {
  UserRepository _userRepository = UserRepositoryImpl();

  @override
  Future<UserModel> call(NoParams params) async {
    UserModel userModel = await _userRepository.get();
    if (userModel == null) {
      userModel = await _userRepository.create(UserModel());
    }
    return userModel;
  }
}
