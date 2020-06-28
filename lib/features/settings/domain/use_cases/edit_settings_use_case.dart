import 'package:equatable/equatable.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';
import 'package:tavtestproject1/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:tavtestproject1/features/settings/domain/repositories/settings_repository.dart';
import 'package:tavtestproject1/features/settings/domain/use_cases/get_settings_use_case.dart';

class EditSettingsUseCase
    extends UseCase<SettingsModel, EditSettingsUseCaseParams> {
  SettingsRepository _settingsRepository = SettingsRepositoryImpl();

  @override
  Future<SettingsModel> call(EditSettingsUseCaseParams params) async {
    SettingsModel settingsModel =
        await _settingsRepository.edit(params.settingsModel);
    return settingsModel;
  }
}

class EditSettingsUseCaseParams extends Equatable {
  final SettingsModel settingsModel;

  EditSettingsUseCaseParams(this.settingsModel);

  @override
  List<Object> get props => [settingsModel];
}
