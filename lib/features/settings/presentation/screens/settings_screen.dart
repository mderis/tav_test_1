import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/core/widgets/drawer.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';
import 'package:tavtestproject1/features/settings/presentation/bloc/bloc.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsBloc _settingsBloc;

  @override
  void initState() {
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    _settingsBloc.add(GetSettingsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _settingsBloc,
      builder: (context, state) {
        return Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            title: Text(translate(Lz.Settings_Page_Title)),
          ),
          body: SettingsList(
            sections: [
              SettingsSection(
                title: translate(Lz.Settings_Section_General_Label),
                tiles: [
                  SettingsTile(
                    title: translate(Lz.Settings_Item_Language_Label),
                    subtitle: state.settingsModel.localeString == 'en'
                        ? "English"
                        : 'فارسی',
                    leading: Icon(Icons.language),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _changeLanguageDialog(_settingsBloc, state);
                        },
                      );
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: translate(translate(Lz.Settings_Section_Ui_Label)),
                tiles: [
                  SettingsTile.switchTile(
                    title:
                        translate(translate(Lz.Settings_Item_Dark_Theme_Label)),
                    leading: Icon(Icons.face),
                    switchValue: state.settingsModel.isDarkTheme,
                    enabled: true,
                    onToggle: (bool value) {
                      SettingsModel newSettings = state.settingsModel;
                      newSettings.isDarkTheme = value;
                      _settingsBloc.add(UpdateSettingsEvent(newSettings));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  SimpleDialog _changeLanguageDialog(
      SettingsBloc settingsBloc, SettingsUpdatedState state) {
    return SimpleDialog(
      title: Text(translate(Lz.Dialog_Text_Select_Language)),
      children: <Widget>[
        SimpleDialogOption(
          child: const Text('English'),
          onPressed: () {
            _settingsBloc.add(
              UpdateSettingsEvent(state.settingsModel..localeString = "en"),
            );
            Navigator.of(context).pop();
          },
        ),
        SimpleDialogOption(
          child: const Text('فارسی'),
          onPressed: () {
            _settingsBloc.add(
              UpdateSettingsEvent(state.settingsModel..localeString = "fa"),
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
