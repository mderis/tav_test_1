import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserBloc _userBloc;
  UserModel userModel = UserModel(username: "", password: "");

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is UserLoginSuccessedState) {
            Navigator.pushReplacementNamed(context, '/product/list');
          } else if (state is UserLoginFailedState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Wrong credentials!")));
          }
        },
        builder: (context, state) {
          return Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: "Username"),
                onChanged: (text) {
                  userModel.username = text;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Password"),
                onChanged: (text) {
                  userModel.password = text;
                },
              ),
              FlatButton(
                child: Text("Login"),
                onPressed: () {
                  _userBloc.add(
                      LoginUserEvent(userModel.username, userModel.password));
                },
              )
            ],
          );
        },
      ),
    );
  }
}
