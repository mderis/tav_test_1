import 'package:sembast/sembast.dart';
import 'package:tavtestproject1/core/database/app_database.dart';
import 'package:tavtestproject1/features/settings/data/models/settings_model.dart';

class SettingsLocaleDataSource {
  Future<Database> get _db async => await AppDatabase.instance.database;

  var _store = intMapStoreFactory.store('settings');

  Future<SettingsModel> get() async {
    Finder finder = Finder();
    var snapshot = await _store.find(await _db, finder: finder);
    if (snapshot.length == 0){
      return null;
    }
    else{
      SettingsModel settingsModel = SettingsModel.fromJson(snapshot[0].value);
      return settingsModel;
    }
  }

  Future<SettingsModel> create(SettingsModel settingsModel) async {
    await _store.add(await _db, settingsModel.toJson());
    return settingsModel;
  }

  Future<SettingsModel> edit(SettingsModel settingsModel) async {
    Finder finder = Finder();
    await _store.update(await _db, settingsModel.toJson(), finder: finder);
    return settingsModel;
  }
}
