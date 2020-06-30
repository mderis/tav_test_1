import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class ProfileEditPasswordScreen extends StatefulWidget {
  @override
  _ProfileEditPasswordScreenState createState() =>
      _ProfileEditPasswordScreenState();
}

class _ProfileEditPasswordScreenState extends State<ProfileEditPasswordScreen> {
  UserBloc _userBloc;
  String oldPassword;
  String newPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          if (state is UserPasswordUpdatedState) {
            if (state.isUpdated)
              Navigator.of(context).pop();
            else
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(translate(Lz.Error_Wrong_Old_Password)),
              ));
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    decoration: new InputDecoration(
                      labelText: translate(Lz.General_Old_Password),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return translate(Lz.Error_Empty_Field_Message);
                      }
                      return null;
                    },
                    onChanged: (value) {
                      oldPassword = value;
                    },
                    obscureText: true,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    decoration: new InputDecoration(
                        labelText: translate(Lz.General_New_Password)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return translate(Lz.Error_Empty_Field_Message);
                      }
                      return null;
                    },
                    onChanged: (value) {
                      newPassword = value;
                    },
                    obscureText: true,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    decoration: new InputDecoration(
                        labelText: translate(Lz.General_Repeat_New_Password)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return translate(Lz.Error_Empty_Field_Message);
                      }else if(newPassword != value)
                        return translate(Lz.Error_Passwords_Dont_Match);
                      return null;
                    },
                    obscureText: true,
                  ),
                  RaisedButton(
                    child: Text(translate(Lz.General_Edit)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _userBloc.add(
                            UpdateUserPasswordEvent(oldPassword, newPassword));
                        //Navigator.of(context).pop();
                      }
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
