import '/models/user/settingsUser.dart';

abstract class LocalStorageInterfaceUser {
  Future<String?> getToken();
  Future<String?> saveToken(String token);
  Future<UserSettings> getUserSettings();
  Future<UserSettings> setUserSettings(UserSettings userSettings);
}
