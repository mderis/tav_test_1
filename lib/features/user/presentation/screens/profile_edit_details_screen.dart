import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class ProfileEditDetailsScreen extends StatefulWidget {
  @override
  _ProfileEditDetailsScreenState createState() => _ProfileEditDetailsScreenState();
}

class _ProfileEditDetailsScreenState extends State<ProfileEditDetailsScreen> {
  UserBloc _userBloc;
  UserModel _userModel = UserModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetOrCreateUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UserReadyToUseState)
          setState(() {
            _userModel = state.userModel;
          });
      },
      builder: (context, state) {
        if (state is UserReadyToUseState) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        OutlineButton(
                          borderSide: BorderSide.none,
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircleAvatar(
                              backgroundImage: _userModel.avatarPath == null
                                  ? AssetImage(
                                      "assets/images/default_product.png")
                                  : FileImage(File(_userModel.avatarPath)),
                              radius: 15,
                            ),
                          ),
                          onPressed: () async {
                            final pickedFile = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            setState(() {
                              _userModel.avatarPath = pickedFile.path;
                            });
                          },
                        ),
                        Visibility(
                          visible: _userModel.avatarPath != null,
                          child: Positioned(
                            left: 0,
                            right: 150,
                            bottom: 0,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  _userModel.avatarPath = null;
                                });
                                ;
                              },
                              color: Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(.5),
                              child: Icon(
                                Icons.delete,
                                color: Colors.blue[800],
                                size: 32,
                              ),
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                            ),
                          ),
                        )
                      ],
                    ),
                    TextFormField(
                      initialValue: state.userModel.username,
                      decoration: new InputDecoration(
                          labelText: translate(Lz.General_Username),),
                      style: TextStyle(color: Colors.black38),
                      enabled: false,
                    ),
                    TextFormField(
                      initialValue: state.userModel.name,
                      decoration: new InputDecoration(
                          labelText: translate(Lz.General_Name)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return translate(Lz.Error_Empty_Field_Message);
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _userModel.name = value;
                      },
                    ),
                    RaisedButton(
                      child: Text(translate(Lz.General_Edit)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _userBloc.add(UpdateUserEvent(_userModel));
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return null;
      },
    );
  }
}
