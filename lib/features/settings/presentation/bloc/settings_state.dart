import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsUpdatedState extends SettingsState {
  final SettingsModel settingsModel;

  SettingsUpdatedState(this.settingsModel);

  @override
  List<Object> get props => [settingsModel];
}

class UpdateSettingState extends SettingsState {
  final SettingsModel settingsModel;

  UpdateSettingState(this.settingsModel);

  @override
  List<Object> get props => [settingsModel];
}
