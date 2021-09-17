import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:sshare/controllers/users_controller.dart';
import 'package:sshare/models/comment.dart';

import 'package:sshare/models/post.dart';

class PostsController extends GetxController {
  UsersController usersController = Get.find();
  var posts = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void incrementLikes(int index){
    posts[index].likesCount += 1;
    update();
  }

  void addComment(int id, Comment comment){
    Post post = posts.firstWhere((post) => post.id == id);
    post.comments.insert(0, comment);
    update();
  }

  void fetchPosts() async {
    String? postsString = await rootBundle.loadString('assets/posts.json');
    if (postsString != null) {
      var postsJson = jsonDecode(postsString);
      for (var postJson in postsJson) {
        var comments = postJson["comments"].map((commentJson) {
          var from = usersController.users.firstWhere((user) => user.id == commentJson["from"]);
          return {
            "id": commentJson["id"],
            "from": from.toJson(),
            "message": commentJson["message"]
          };
        }).toList();
        postJson["from"] = usersController.users.firstWhere((user) => user.id == postJson["from"]).toJson();
        postJson["comments"] = comments;
        Post post = Post.fromJson(postJson);
        posts.add(post);
      }
    }
  }
}
