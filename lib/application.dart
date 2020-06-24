import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';
import 'package:tavtestproject1/screens/main_screen.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocProvider(create: (BuildContext context)=> ProductBloc(),
      child: MainScreen(),),
    );
  }
}
