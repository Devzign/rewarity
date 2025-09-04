import 'package:shared_preferences/shared_preferences.dart';

abstract class KVStore {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
}

class KVStoreImpl implements KVStore {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  @override
  Future<String?> read(String key) async => (await _prefs).getString(key);

  @override
  Future<void> write(String key, String value) async {
    await (await _prefs).setString(key, value);
  }
}
