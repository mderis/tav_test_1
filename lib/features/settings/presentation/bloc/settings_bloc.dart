import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';
import 'package:tavtestproject1/features/settings/domain/use_cases/edit_settings_use_case.dart';
import 'package:tavtestproject1/features/settings/domain/use_cases/get_settings_use_case.dart';
import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  GetSettingsUseCase _getSettingsUseCase = GetSettingsUseCase();
  EditSettingsUseCase _editSettingsUseCase = EditSettingsUseCase();

  @override
  SettingsState get initialState => SettingsUpdatedState(SettingsModel.getDefault());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is GetSettingsEvent) {
      SettingsModel settingsModel = await _getSettingsUseCase(NoParams());
      yield SettingsUpdatedState(settingsModel);
    } else if (event is UpdateSettingsEvent) {
      SettingsModel settingsModel = await _editSettingsUseCase(
          EditSettingsUseCaseParams(event.settingsModel));
      yield SettingsUpdatedState(settingsModel);
    }
  }
}
