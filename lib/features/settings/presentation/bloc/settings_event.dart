import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetSettingsEvent extends SettingsEvent {}

class UpdateSettingsEvent extends SettingsEvent {
  final SettingsModel settingsModel;

  UpdateSettingsEvent(this.settingsModel);

  @override
  List<Object> get props => [settingsModel];
}
