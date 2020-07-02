import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/user/presentation/bloc/bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    Future.delayed(
      Duration(seconds: 3),
      () async {
        _userBloc.add(GetOrCreateUserEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UserReadyToUseState) {
          Navigator.pushReplacementNamed(context, '/product/shop');
//          Navigator.pushReplacementNamed(context, '/product/list');
//        Navigator.pushReplacementNamed(context, '/login');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                'assets/images/bg.png',
                repeat: ImageRepeat.repeat,
              ),
              _getTextWidgets()
            ],
          ),
        );
      },
    );
  }

  _getTextWidgets() {
    return Align(
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
