import '/models/user/loginUser.dart';
import '/models/user/settingsUser.dart';
import '/models/user/signUpUser.dart';

abstract class ApiStorageInterfaceUser {
  Future<UserSettings> getUserFromToken(String token);
  Future<String> loginUser(LoginUser user);
  Future<void> registerUser(SignUpUser user);
  Future<bool> changeUserSettings(String token, UserSettings user);
}
