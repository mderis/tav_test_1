import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      condition: (previousState, newState) {
        return newState is UserUpdatedState;
      },
      builder: (context, state) {
        UserModel userModel = (state as UserUpdatedState).userModel;
        return Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(userModel.name),
                accountEmail: Text(userModel.username),
                currentAccountPicture: userModel.avatarPath == null
                    ? CircleAvatar(
                        backgroundColor:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? Colors.blue
                                : Colors.white,
                        child: Text(
                          userModel.name.substring(0, 1),
                          style: TextStyle(fontSize: 40.0),
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(userModel.avatarPath)),
                        radius: 15,
                      ),
              ),
              ..._getListItems(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getListItems() {
    return [
      ListTile(
        leading: Icon(Icons.pregnant_woman),
        title: Text("Edit Profile"),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.list),
        title: Text(translate(Lz.Product_List_Title)),
        onTap: () {},
      ),
    ];
  }
}
