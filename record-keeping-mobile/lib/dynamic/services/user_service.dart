import 'dart:convert';
import 'package:http/http.dart';
import 'package:record_keeping/dynamic/models/user_model.dart';
import 'package:record_keeping/static/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserService {
  CustomString api = CustomString();

  //POST USER
  Future postUser(User user) async {
    var userJson = jsonEncode(user);
    Response response = await post("${api.endPoint}/user",
        body: userJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("USER POSTED");
    } else {
      throw "can't post user";
    }
  }

  // UPDATE USER
  Future<bool> updateUserById(User user, String id) async {
    var userJson = jsonEncode(user);
    Response response = await put("${api.endPoint}/user/$id",
        body: userJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("USER UPDATED");
      return true;
    } else {
      throw "can't update user";
    }
  }

  // get a user
  Future<User> getUserById({String uid}) async {
    Response response = await get("${api.endPoint}/user/$uid",
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    print('body: [${response.body}]');
    if (response.statusCode == 200) {
      dynamic userObj = jsonDecode(response.body);
      print(userObj);
      User user = User.fromJson(userObj);
      print(user);
      return user;
    } else {
      throw "can't get user";
    }
  }

  // get all users
  Future<List<User>> getAllUsers() async {
    Response response = await get("${api.endPoint}/users",
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    print('body: [${response.body}]');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<User> users =
          body.map((dynamic item) => User.fromJson(item)).toList();
      print(users);
      return users;
    } else {
      throw "can't get user";
    }
  }

  //login with user

  Future<User> login(String email) async {
    Response response = await get("${api.endPoint}/login/$email",
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic userObj = jsonDecode(response.body);
      print(userObj);
      User user = User.fromJson(userObj);
      print(user);
      return user;
    } else {
      throw "can't get user";
    }
  }
}
