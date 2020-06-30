import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserBloc _userBloc;
  UserModel userModel = UserModel(username: "", password: "");

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetOrCreateUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(Lz.General_Login)),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is UserLoginSucceedState) {
            Navigator.pushReplacementNamed(context, '/product/list');
          } else if (state is UserLoginFailedState) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(translate(Lz.Error_Wrong_Credentials))));
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  new TextFormField(
                    textDirection: TextDirection.ltr,
                    decoration: new InputDecoration(
                        labelText: translate(Lz.General_Username)),
                    onChanged: (text) {
                      userModel.username = text;
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return translate(Lz.Error_Empty_Field_Message);
                      else
                        return null;
                    },
                  ),
                  new TextFormField(
                    textDirection: TextDirection.ltr,
                    decoration: new InputDecoration(
                        labelText: translate(Lz.General_Password)),
                    onChanged: (text) {
                      userModel.password = text;
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return translate(Lz.Error_Empty_Field_Message);
                      else
                        return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  FlatButton(
                    child: Text(translate(Lz.General_Login)),
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        _userBloc.add(LoginUserEvent(
                            userModel.username, userModel.password));
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
