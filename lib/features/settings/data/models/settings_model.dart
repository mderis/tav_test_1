import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  String localeString;
  bool isDarkTheme;

  SettingsModel({this.localeString = 'en', this.isDarkTheme = false});

  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      localeString: json['locale_string'],
      isDarkTheme: json['is_dark_theme'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locale_string': localeString,
      'is_dark_theme': isDarkTheme,
    };
  }

  @override
  List<Object> get props => [localeString, isDarkTheme];
}
