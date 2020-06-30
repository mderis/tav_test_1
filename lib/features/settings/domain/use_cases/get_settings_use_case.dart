import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';
import 'package:tavtestproject1/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:tavtestproject1/features/settings/domain/repositories/settings_repository.dart';

class GetSettingsUseCase extends UseCase<SettingsModel, NoParams> {
  SettingsRepository _settingsRepository = SettingsRepositoryImpl();

  @override
  Future<SettingsModel> call(NoParams params) async {
    SettingsModel settingsModel = await _settingsRepository.get();
    if (settingsModel == null) {
      settingsModel = await _settingsRepository.create(SettingsModel.getDefault());
    }
    return settingsModel;
  }
}
