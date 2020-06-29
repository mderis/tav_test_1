import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserUpdatedState extends UserState {
  final UserModel userModel;
  final ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  UserUpdatedState(this.userModel);

  @override
  List<Object> get props => [userModel, ageNabasheEquatabilityKarNemikone];
}

class UserPasswordUpdatedState extends UserState {
  final bool isUpdated;

  UserPasswordUpdatedState(this.isUpdated);

  @override
  List<Object> get props => [isUpdated];
}

class UserLoginSuccessedState extends UserState {
  final UserModel userModel;
  final _ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  UserLoginSuccessedState(this.userModel);

  @override
  List<Object> get props => [userModel, _ageNabasheEquatabilityKarNemikone];
}

class UserLoginFailedState extends UserState {
  final _ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  @override
  List<Object> get props => [_ageNabasheEquatabilityKarNemikone];
}
