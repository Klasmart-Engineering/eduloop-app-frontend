import 'dart:convert';

import 'package:edu_app/services/local_storage_service.dart';
import 'package:flutter/material.dart';

import 'package:edu_app/models/user.dart';
import 'package:edu_app/constants/storage_keys.dart';

class UserService {
  static Future<List<User>> getUsers() async {
    String? usersListValue = await LocalStorageService.get(keyUserList);
    if (usersListValue == null) {
      return [];
    }

    Iterable usersListJson = jsonDecode(usersListValue);
    List<User> users =
        List<User>.from(usersListJson.map((model) => User.fromJson(model)));

    return users;
  }

  static Future<User> addNewUser(String name) async {
    List<User> users = await getUsers();
    User newUser = User.newUser(name);
    users.add(newUser);

    String userJson = jsonEncode(users);
    LocalStorageService.store(keyUserList, userJson);

    return newUser;
  }
}
