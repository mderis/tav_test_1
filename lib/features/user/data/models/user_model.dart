import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String name;
  String username;
  String password;
  String avatarPath;

  UserModel({
    this.name = 'Moslem',
    this.username = 'admin',
    this.password = "admin",
    this.avatarPath,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      avatarPath: json['avatar_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'avatar_path': avatarPath,
    };
  }

  @override
  List<Object> get props => [name, username, password, avatarPath];
}
