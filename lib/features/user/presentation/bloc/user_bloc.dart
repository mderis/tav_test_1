import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/edit_user_use_case.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/get_user_use_case.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  GetUserUseCase _getUserUseCase = GetUserUseCase();
  EditUserUseCase _editUserUseCase = EditUserUseCase();

  @override
  UserState get initialState => UserUpdatedState(UserModel());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoginUserEvent) {
      print([event.username, event.password]);
      UserModel userModel = await _getUserUseCase(NoParams());
      print([userModel.username, userModel.password]);
      if (event.username == userModel.username &&
          event.password == userModel.password) {
        yield UserLoginSuccessedState(userModel);
      } else {
        yield UserLoginFailedState();
      }
    } else if (event is GetUserEvent) {
      UserModel userModel = await _getUserUseCase(NoParams());
      yield UserUpdatedState(userModel);
    } else if (event is UpdateUserEvent) {
      UserModel userModel =
          await _editUserUseCase(EditUserUseCaseParams(event.userModel));
      yield UserUpdatedState(userModel);
    }
  }
}
