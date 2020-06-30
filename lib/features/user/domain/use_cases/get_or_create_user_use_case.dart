import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/create_user_use_case.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/get_user_use_case.dart';

class GetOrCreateUserUseCase extends UseCase<UserModel, NoParams> {
  CreateUserUseCase _createUserUseCase = CreateUserUseCase();
  GetUserUseCase _getUserUseCase = GetUserUseCase();

  @override
  Future<UserModel> call(NoParams params) async {
    UserModel userModel = await _getUserUseCase(NoParams());
    if (userModel == null) userModel = await _createUserUseCase(NoParams());
    return userModel;
  }
}
