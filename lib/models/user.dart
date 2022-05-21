// https://stackoverflow.com/questions/53931513/store-data-as-an-object-in-shared-preferences-in-flutter
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;

  User({required this.name, required this.id});

  factory User.newUser(String name) {
    var uuid = const Uuid();

    return User(id: uuid.v4(), name: name);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "id": id};
  }
}
