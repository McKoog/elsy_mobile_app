import 'dart:convert';
import 'dart:io';

import '/constants.dart';
import '/infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '/models/user/signUpUser.dart';
import '/models/user/settingsUser.dart';
import '/models/user/loginUser.dart';
import 'package:http/http.dart' as http;

class ApiStorageImplUser extends ApiStorageInterfaceUser {
  @override
  Future<UserSettings> getUserFromToken(String token) async {
    print("${Uri.parse(baseUrl + "/api/user/" + token)}");
    var request = await http.get(
      Uri.parse(baseUrl + "/api/user/$token"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(request.body);
    if (request.statusCode == 200) {
      print("${UserSettings.fromJson(jsonDecode(request.body))}");
      return UserSettings.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Error! Bad data!");
    }
  }

  @override
  Future<bool> changeUserSettings(String token, UserSettings user) async {
    final queryParametr = {'token': token};
    var uri = Uri.http(
        "192.168.4.22:80", "/api/user/edit-user-settings", queryParametr);
    var request = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': token,
          'name': user.name,
          'email': user.email,
          'fuelType': user.fuelType,
          "fuelSize": user.fuelSize
        }));
    print(request.statusCode);
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> loginUser(LoginUser user) async {
    var request = await http.post(Uri.parse(baseUrl + "/api/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"email": user.email, "password": user.password}));
    print("${Uri.parse(baseUrl + "/api/user/login")}");
    print("${request.body}");
    if (request.statusCode == 200) {
      return json.decode(request.body);
    } else {
      return "";
    }
  }

  @override
  Future<bool> registerUser(SignUpUser user) async {
    var request = await http.post(Uri.parse(baseUrl + "/api/user/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": user.name,
          "email": user.email,
          "password": user.password,
          "mobile": user.mobile,
        }));
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}