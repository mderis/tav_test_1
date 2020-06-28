import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/data/repositories/user_repository_impl.dart';
import 'package:tavtestproject1/features/user/domain/repositories/user_repository.dart';

class CreateUserUseCase extends UseCase<UserModel, CreateUserUseCaseParams> {
  UserRepository _userRepository = UserRepositoryImpl();

  @override
  Future<UserModel> call(CreateUserUseCaseParams params) {
    return _userRepository.create(
        UserModel(username: params.username, password: params.username));
  }
}

class CreateUserUseCaseParams extends Equatable {
  final String username;
  final String password;

  CreateUserUseCaseParams(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
