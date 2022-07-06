import 'dart:convert';
import '/constants.dart';
import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/models/user/signUpUser.dart';
import '/models/user/settingsUser.dart';
import '/models/user/loginUser.dart';
import 'package:http/http.dart' as http;

class ApiStorageImplUser extends ApiStorageInterfaceUser {
  @override
  Future<UserSettings> getUserFromToken(String token,String UserApiKey) async {

    Uri uri = Uri.https(baseUrl, '/User/GetUserSettingsFromToken',
        {"token" : token});
    var response = await http.get(uri,headers: {
      "Accept": "text/plain",
      "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
      "Access-Control-Allow-Credentials" : 'true',
      "Authorization" : "Bearer " + UserApiKey
    });

    print(uri);
    print(response.body);

    if (response.statusCode == 200) {
      print("${UserSettings.fromJson(jsonDecode(response.body/*response.body*/))}");
      return UserSettings.fromJson(jsonDecode(response.body/*response.body*/));
    } else {
      throw Exception("Error! Bad data!");
    }

  }

  @override
  Future<bool> changeUserSettings(String token, UserSettings user, String UserApiKey) async {

    Uri uri = Uri.https(baseUrl, '/User/ChangeUserSettings',
        {"token" : token, "name" : user.name, "email" : user.email, "fuelType" : user.fuelType, "fuelSize": user.fuelSize});
    final response = await http.post(uri,headers: {
      "Accept": "text/plain",
      "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
      "Access-Control-Allow-Credentials" : 'true',
      "Authorization" : "Bearer " + UserApiKey
    });
    print(uri);
    print("${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> loginUser(LoginUser user) async {

    Uri uri = Uri.https(baseUrl, '/User/LoginUser',
        {"email" : user.email,"password" : user.password});
    print(uri);
    var response = await http.get(uri,headers: {
      "Accept": "text/plain",
      "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
      "Access-Control-Allow-Credentials" : 'true'
    });
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }

  @override
  Future<bool> registerUser(SignUpUser user) async {
    Uri uri = Uri.https(baseUrl, '/User/RegisterUser',
        {"id": "4", "name": user.name, "email" : user.email,"password" : user.password, "phone" : user.mobile, "role" : "standart"});
    var request = await http.post(uri,headers: {
      "Accept": "text/plain",
      "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
      "Access-Control-Allow-Credentials" : 'true'
    });
    print(uri);
    print("${request.body}");
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

@override
Future<String> authorizeApiUser(String token) async {
  Uri uri = Uri.https(baseUrl, '/User/AuthorizeApiUser',
      {"token" : token});
  var request = await http.get(uri,headers: {
    "Accept": "text/plain",
    "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
    "Access-Control-Allow-Credentials" : 'true'
  });
  print(uri);
  print("${request.body}");
  if (request.statusCode == 200) {
    return request.body;
  } else {
    return "";
  }
  }
}
