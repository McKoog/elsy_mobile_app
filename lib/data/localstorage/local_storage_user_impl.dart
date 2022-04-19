import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/models/user/settingsUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pref_token = "TOKEN";
const pref_email = "EMAIL";
const pref_name = "NAME";
const pref_fuelType = "FUELTYPE";
const pref_fuelSize = "FUELSIZE";

class LocalStorageImplUser extends LocalStorageInterfaceUser {
  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(pref_token);
    return token;
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(pref_token, token);
    return token;
  }

  @override
  Future<UserSettings> getUserSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final name = sharedPreferences.getString(pref_name);
    final email = sharedPreferences.getString(pref_email);
    final fuelType = sharedPreferences.getString(pref_fuelType);
    final fuelSize = sharedPreferences.getString(pref_fuelSize);

    final userSettings = UserSettings(
        name: name!, email: email!, fuelType: fuelType!, fuelSize: fuelSize!);

    return userSettings;
  }

  @override
  Future<UserSettings> setUserSettings(UserSettings userSettings) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(pref_name, userSettings.name);
    sharedPreferences.setString(pref_email, userSettings.email);
    sharedPreferences.setString(pref_fuelType, userSettings.fuelType);
    sharedPreferences.setString(pref_fuelSize, userSettings.fuelSize);

    return userSettings;
  }
}
