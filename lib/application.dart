import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/extensions/hex_color.dart';
import 'package:tavtestproject1/features/settings/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

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
    _settingsBloc.add(PrepareSettingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        bloc: _settingsBloc,
        listener: (context, state) {
          if (state is SettingsReadyToUseState) {
            changeLocale(context, state.settingsModel.localeString);
          }
        },
        builder: (context, state) {
          if (state is SettingsReadyToUseState) {
            return LocalizationProvider(
              state: LocalizationProvider.of(context).state,
              child: MaterialApp(
                title: 'Flutter Demo',
                localizationsDelegates: _getLocalizationDelegates(),
                supportedLocales: _getLocalizationDelegate().supportedLocales,
                locale: Locale(state.settingsModel.localeString),
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: "IranSans",
                  primaryColor:
                      HexColor.fromHex(state.settingsModel.primaryColor),
                ),
                darkTheme: ThemeData.dark(),
                themeMode: state.settingsModel.isDarkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: '/splash',
              ),
            );
          }
          return null;
        });
  }

  LocalizationDelegate _getLocalizationDelegate() =>
      LocalizedApp.of(context).delegate;

  List<LocalizationsDelegate> _getLocalizationDelegates() => [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _getLocalizationDelegate(),
      ];
}
