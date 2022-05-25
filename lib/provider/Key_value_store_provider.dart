import 'package:shared_preferences/shared_preferences.dart';

abstract class KeyValueStore {
  Future<Set<String>> getKeys();

  Future<Object?> get(String key);

  Future<bool?> getBool(String key);

  Future<int?> getInt(String key);

  Future<double?> getDouble(String key);

  Future<String?> getString(String key);

  Future<bool> containsKey(String key);

  Future<List<String>?> getStringList(String key);

  Future<bool> setBool(String key, bool value);

  Future<bool> setInt(String key, int value);

  Future<bool> setDouble(String key, double value);

  Future<bool> setString(String key, String value);

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> remove(String key);

  Future<bool> clear();

  Future<void> reload();
}

class KeyValueStoreImpl implements KeyValueStore {
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  @override
  Future<bool> clear() async => (await sharedPreferences).clear();

  @override
  Future<bool> containsKey(String key) async => (await sharedPreferences).containsKey(key);

  @override
  Future<Object?> get(String key) async => (await sharedPreferences).get(key);

  @override
  Future<bool?> getBool(String key) async => (await sharedPreferences).getBool(key);

  @override
  Future<double?> getDouble(String key) async => (await sharedPreferences).getDouble(key);

  @override
  Future<int?> getInt(String key) async => (await sharedPreferences).getInt(key);

  @override
  Future<Set<String>> getKeys() async => (await sharedPreferences).getKeys();

  @override
  Future<String?> getString(String key) async => (await sharedPreferences).getString(key);

  @override
  Future<List<String>?> getStringList(String key) async => (await sharedPreferences).getStringList(key);

  @override
  Future<void> reload() async => await (await sharedPreferences).reload();

  @override
  Future<bool> remove(String key) async => await (await sharedPreferences).remove(key);

  @override
  Future<bool> setBool(String key, bool value) async => await (await sharedPreferences).setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) async => await (await sharedPreferences).setDouble(key, value);

  @override
  Future<bool> setInt(String key, int value) async => await (await sharedPreferences).setInt(key, value);

  @override
  Future<bool> setString(String key, String value) async => await (await sharedPreferences).setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) async =>
      await (await sharedPreferences).setStringList(key, value);
}
