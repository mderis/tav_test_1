import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';

abstract class SettingsRepository {
  Future<SettingsModel> create(SettingsModel settingsModel);

  Future<SettingsModel> get();

  Future<SettingsModel> edit(SettingsModel settingsModel);
}
