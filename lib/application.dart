import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';
import 'package:tavtestproject1/features/settings/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

SettingsBloc _settingsBloc;

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return BlocListener(
      bloc: _settingsBloc,
      listener: (context, state) {
//        if (state is UpdateSettingState) {
//          print("jjjjjjjjjjjjjjjjjjjjjjjjjj");
//          changeLocale(context, state.settingsModel.localeString);
//        }
      },
      child: BlocBuilder(
          bloc: _settingsBloc,
          builder: (context, state) {
            if (state is UpdateSettingState) {
              changeLocale(context, state.settingsModel.localeString);
            }

            return LocalizationProvider(
              state: LocalizationProvider.of(context).state,
              child: MaterialApp(
                title: 'Flutter Demo',
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  localizationDelegate,
                ],
                supportedLocales: localizationDelegate.supportedLocales,
                locale: Locale(state.settingsModel.localeString),
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    fontFamily: "IranSans"),
                themeMode: state.settingsModel.isDarkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: '/splash',
              ),
            );
          }),
    );

//    return BlocConsumer(
//        bloc: _settingsBloc,
//        listener: (context, state) {
//          SettingsModel settingsModel =
//              (state as SettingsUpdatedState).settingsModel;
//          print("state is captured");
//          print(settingsModel.toJson());
//          changeLocale(context, settingsModel.localeString);
//        },
//        builder: (context, state) {
//          if(state is SettingsUpdatedState){
//            return LocalizationProvider(
//              state: LocalizationProvider.of(context).state,
//              child: MaterialApp(
//                title: 'Flutter Demo',
//                localizationsDelegates: [
//                  GlobalMaterialLocalizations.delegate,
//                  GlobalCupertinoLocalizations.delegate,
//                  GlobalWidgetsLocalizations.delegate,
//                  localizationDelegate,
//                ],
//                supportedLocales: localizationDelegate.supportedLocales,
//                locale: Locale(state.settingsModel.localeString),
//                theme: ThemeData(
//                    primarySwatch: Colors.blue,
//                    visualDensity: VisualDensity.adaptivePlatformDensity,
//                    fontFamily: "IranSans"),
//                themeMode: state.settingsModel.isDarkTheme
//                    ? ThemeMode.dark
//                    : ThemeMode.light,
//                onGenerateRoute: RouteGenerator.generateRoute,
//                initialRoute: '/splash',
//              ),
//            );
//
//          }
//        });
  }
}
