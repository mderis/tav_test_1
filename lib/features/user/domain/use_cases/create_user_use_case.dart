import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/data/repositories/user_repository_impl.dart';
import 'package:tavtestproject1/features/user/domain/repositories/user_repository.dart';

class CreateUserUseCase extends UseCase<UserModel, NoParams> {
  UserRepository _userRepository = UserRepositoryImpl();

  @override
  Future<UserModel> call(NoParams params) {
    return _userRepository.create(
        UserModel(name:"John Doe", username: "admin", password: "admin"));
  }
}
