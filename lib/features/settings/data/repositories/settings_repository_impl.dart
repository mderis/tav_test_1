import 'package:tavtestproject1/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';
import 'package:tavtestproject1/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsLocaleDataSource _settingsLocaleDataSource =
      SettingsLocaleDataSource();

  @override
  Future<SettingsModel> create(SettingsModel settingsModel) {
    return _settingsLocaleDataSource.create(settingsModel);
  }

  @override
  Future<SettingsModel> edit(SettingsModel settingsModel) {
    return _settingsLocaleDataSource.edit(settingsModel);
  }

  @override
  Future<SettingsModel> get() {
    return _settingsLocaleDataSource.get();
  }
}
