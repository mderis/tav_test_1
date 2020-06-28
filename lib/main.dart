import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'application.dart';
import 'features/product/presentation/bloc/bloc.dart';
import 'features/settings/presentation/bloc/bloc.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'fa']);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => ProductBloc(),
        ),
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => SettingsBloc(),
        ),
      ],
      child: LocalizedApp(delegate, Application()),
    ),
  );

}
