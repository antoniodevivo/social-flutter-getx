import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

import 'package:sshare/models/user.dart';

class UsersController extends GetxController {
  var users = [].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchUsers();
  }

  Future fetchUsers() async {
    String? usersString = await rootBundle.loadString('assets/users.json');
    if (usersString != null) {
      var usersJson = jsonDecode(usersString);
      for (var userJson in usersJson) {
        User user = User.fromJson(userJson);
        users.add(user);
      }
    }
  }

  User get loggedUser{
    return users.firstWhere((user) => user.id == 1);
  }
}
