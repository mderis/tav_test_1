import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class LoginUserEvent extends UserEvent {
  final String username;
  final String password;

  LoginUserEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class UpdateUserEvent extends UserEvent {
  final UserModel userModel;

  UpdateUserEvent(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class UpdateUserPasswordEvent extends UserEvent {
  final String oldPassword;
  final String newPassword;

  UpdateUserPasswordEvent(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}
