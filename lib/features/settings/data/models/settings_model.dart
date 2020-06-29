import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  String localeString;
  bool isDarkTheme;
  String primaryColor;

  SettingsModel(
      {this.localeString = 'en',
      this.isDarkTheme = false,
      this.primaryColor = "#ff0000"});

  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      localeString: json['locale_string'],
      isDarkTheme: json['is_dark_theme'],
      primaryColor: json['primary_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locale_string': localeString,
      'is_dark_theme': isDarkTheme,
      'primary_color': primaryColor,
    };
  }

  @override
  List<Object> get props => [localeString, isDarkTheme, primaryColor];
}
