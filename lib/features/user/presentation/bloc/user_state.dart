import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserReadyToUseState extends UserState {
  final UserModel userModel;
  final ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  UserReadyToUseState(this.userModel);

  @override
  List<Object> get props => [userModel, ageNabasheEquatabilityKarNemikone];
}

class UserPasswordUpdatedState extends UserState {
  final bool isUpdated;

  UserPasswordUpdatedState(this.isUpdated);

  @override
  List<Object> get props => [isUpdated];
}

class UserLoginSucceedState extends UserState {
  final UserModel userModel;
  final _ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  UserLoginSucceedState(this.userModel);

  @override
  List<Object> get props => [userModel, _ageNabasheEquatabilityKarNemikone];
}

class UserLoginFailedState extends UserState {
  final _ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  @override
  List<Object> get props => [_ageNabasheEquatabilityKarNemikone];
}
