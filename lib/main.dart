import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'application.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'fa']);

  runApp(LocalizedApp(delegate, Application()));
}
