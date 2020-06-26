import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    changeLocale(context, 'fa');
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/product/list');
    });
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
