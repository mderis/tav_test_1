import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/presentation/screens/profile_edit_details_screen.dart';
import 'package:tavtestproject1/features/user/presentation/screens/profile_edit_password_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate(Lz.Profile_Edit_Page_Title)),
          bottom: TabBar(
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(translate(Lz.Profile_Edit_Page_Details_Title)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(translate(Lz.Profile_Edit_Page_Password_Title)),
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ProfileEditDetailsScreen(),
          ProfileEditPasswordScreen(),
        ],),
      ),
    );
  }
}
