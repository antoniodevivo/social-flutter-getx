import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sshare/controllers/posts_controller.dart';
import 'package:sshare/controllers/users_controller.dart';
import 'package:sshare/views/home_page.dart';
import 'package:sshare/views/new_post_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Get.put(UsersController());
    Get.put(PostsController());
    return GetMaterialApp(
      title: 'Sshare',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: Colors.indigo[900],
          )),
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
