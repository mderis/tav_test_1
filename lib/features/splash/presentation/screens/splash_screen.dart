import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/user/data/models/user_model.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/create_user_use_case.dart';
import 'package:tavtestproject1/features/user/domain/use_cases/get_user_use_case.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CreateUserUseCase _createUserUseCase = CreateUserUseCase();
  GetUserUseCase _getUserUseCase = GetUserUseCase();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () async {
        UserModel userModel = await _getUserUseCase(NoParams());
        if (userModel == null) {
          await _createUserUseCase(CreateUserUseCaseParams("admin", "admin"));
        }
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/bg.png',
            repeat: ImageRepeat.repeat,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    translate(Lz.Fepco),
                    style: TextStyle(fontSize: 64),
                  ),
                  decoration: _getTextBgDecoration(),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Text(
                    translate(Lz.Modern_Shopping_System),
                    style: TextStyle(fontSize: 24),
                  ),
                  decoration: _getTextBgDecoration(),
                ),
                SizedBox(
                  height: 96,
                ),
                CircularProgressIndicator()
              ],
            ),
          )
        ],
      ),
    );
  }

  _getTextBgDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(.8),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    );
  }
}
