import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class MainDrawer extends StatefulWidget {
  final String _routeName;

  MainDrawer(this._routeName);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUserEvent());
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
                          userModel.name.length > 0
                              ? userModel.name.substring(0, 1)
                              : "?",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(userModel.avatarPath)),
                        radius: 15,
                      ),
              ),
              ..._getListItems(context),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getListItems(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.person),
        title: Text(translate(Lz.Profile_Edit_Page_Title)),
        enabled: widget._routeName != '/profile/edit',
        onTap: () {
          Navigator.of(context).popAndPushNamed('/profile/edit');
        },
      ),
      ListTile(
        leading: Icon(Icons.list),
        title: Text(translate(Lz.Product_List_Title)),
        enabled: widget._routeName != '/product/list',
        onTap: () {
          Navigator.of(context).popAndPushNamed('/product/list');
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text(translate(Lz.Settings_Page_Title)),
        enabled: widget._routeName != '/settings',
        onTap: () {
          Navigator.of(context).popAndPushNamed('/settings');
        },
      ),
    ];
  }
}
