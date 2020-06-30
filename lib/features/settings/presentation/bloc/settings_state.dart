import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsReadyToUseState extends SettingsState {
  final SettingsModel settingsModel;
  final ageNabasheEquatabilityKarNemikone = DateTime.now().toString();

  SettingsReadyToUseState(this.settingsModel);

  @override
  List<Object> get props => [settingsModel, ageNabasheEquatabilityKarNemikone];
}