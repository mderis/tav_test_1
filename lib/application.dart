import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'features/product/presentation/bloc/bloc.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: BlocProvider(
        create: (BuildContext context) => ProductBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: '/splash',
        ),
      ),
    );
  }
}
