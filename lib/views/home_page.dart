import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sshare/components/post_components.dart';
import 'package:sshare/views/new_post_page.dart';
import 'package:sshare/controllers/posts_controller.dart';

class HomePage extends StatelessWidget {
  PostsController postsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sshare")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                child: Text("New post"),
                onPressed: () {
                  Get.to(() => NewPostPage());
                },
              ))
            ],
          ),
          getPostsListComponent(postsController.posts)
        ],
      ),
    );
  }
}
