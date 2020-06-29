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

    return BlocConsumer<SettingsBloc, SettingsState>(
        bloc: _settingsBloc,
        listener: (context, state) {
          if (state is SettingsUpdatedState) {
            changeLocale(context, state.settingsModel.localeString);
          }
        },
        builder: (context, state) {
          if (state is SettingsUpdatedState) {
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
                darkTheme: ThemeData.dark(),
                themeMode: state.settingsModel.isDarkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: '/splash',
              ),
            );
          }
        });
  }
}
