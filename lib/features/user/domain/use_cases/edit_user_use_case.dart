import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/data/repositories/user_repository_impl.dart';
import 'package:tavtestproject1/features/user/domain/repositories/user_repository.dart';

class EditUserUseCase extends UseCase<UserModel, EditUserUseCaseParams> {
  UserRepository _userRepository = UserRepositoryImpl();

  @override
  Future<UserModel> call(EditUserUseCaseParams params) {
    return _userRepository.edit(params.userModel);
  }
}

class EditUserUseCaseParams extends Equatable {
  final UserModel userModel;

  EditUserUseCaseParams(this.userModel);

  @override
  List<Object> get props => [userModel];
}
