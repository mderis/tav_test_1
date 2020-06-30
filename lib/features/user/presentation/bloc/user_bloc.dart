import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/edit_user_use_case.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/get_or_create_user_use_case.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  GetOrCreateUserUseCase _getOrCreateUserUseCase = GetOrCreateUserUseCase();
  EditUserUseCase _editUserUseCase = EditUserUseCase();

  @override
  UserState get initialState => UserReadyToUseState(UserModel());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoginUserEvent) {
      UserModel userModel = await _getOrCreateUserUseCase(NoParams());
      if (event.username == userModel.username &&
          event.password == userModel.password) {
        yield UserLoginSucceedState(userModel);
      } else {
        yield UserLoginFailedState();
      }
    } else if (event is GetOrCreateUserEvent) {
      UserModel userModel = await _getOrCreateUserUseCase(NoParams());
      yield UserReadyToUseState(userModel);
    } else if (event is UpdateUserEvent) {
      UserModel userModel =
          await _editUserUseCase(EditUserUseCaseParams(event.userModel));
      yield UserReadyToUseState(userModel);
    } else if (event is UpdateUserPasswordEvent) {
      UserModel userModel = await _getOrCreateUserUseCase(NoParams());
      if (userModel.password == event.oldPassword) {
        userModel.password = event.newPassword;
        add(UpdateUserEvent(userModel));
        yield UserPasswordUpdatedState(true);
      } else {
        yield UserPasswordUpdatedState(false);
      }
    }
  }
}
