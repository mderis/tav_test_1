import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tavtestproject1/core/localization/lz.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: translate(Lz.Settings_Section_General_Label),
            tiles: [
              SettingsTile(
                title: translate(Lz.Settings_Item_Language_Label),
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {
                  changeLocale(context, "en");
                },
              ),
              SettingsTile(
                title: translate(Lz.Settings_Item_Language_Label),
                subtitle: 'فارسی',
                leading: Icon(Icons.language),
                onTap: () {
                  changeLocale(context, "fa");
                },
              ),
            ],
          ),
          SettingsSection(
            title: translate(translate(Lz.Settings_Section_Ui_Label)),
            tiles: [
              SettingsTile.switchTile(
                title: translate(translate(Lz.Settings_Item_Dark_Theme_Label)),
                leading: Icon(Icons.face),
                switchValue: true,
                enabled: false,
                onToggle: (bool value) {

                },
              ),
            ],
          ),
        ],
      )
      ,
    );
  }
}
