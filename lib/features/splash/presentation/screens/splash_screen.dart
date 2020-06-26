import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3),(){
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
                    "FEPCO",
                    style: TextStyle(fontSize: 64),
                  ),
                  decoration: _getTextBgDecoration(),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Text(
                    "shopping system",
                    style: TextStyle(fontSize: 32),
                  ),
                  decoration: _getTextBgDecoration(),
                ),
                SizedBox(height: 96,),
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
