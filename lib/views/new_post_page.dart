import 'dart:io';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sshare/controllers/new_post_controller.dart';
import 'package:sshare/controllers/posts_controller.dart';
import 'package:sshare/controllers/users_controller.dart';
import 'package:sshare/models/post.dart';

class NewPostPage extends StatelessWidget {
  UsersController usersController = Get.find();
  PostsController postsController = Get.find();
  NewPostController newPostController = Get.put(NewPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post")),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter your text'),
            onChanged: (String text) {
              newPostController.message = RxString(text);
            },
          ),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                child: Text("Send"),
                onPressed: () {
                  postsController.posts.insert(
                      0,
                      Post(
                          0,
                          usersController.loggedUser,
                          null,
                          null,
                          newPostController.message.toString(),
                          0,
                          [],
                          "now"));
                  Get.back();
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
