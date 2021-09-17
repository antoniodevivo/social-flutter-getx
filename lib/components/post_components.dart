import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sshare/controllers/posts_controller.dart';
import 'package:sshare/models/post.dart';
import 'package:sshare/views/post_details_page.dart';

PostsController postsController = Get.find();

Widget getPostsListComponent(var posts) {
  return Expanded(
      child: Obx(() => Scrollbar(
          child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return buildPostCard(context, posts[index], index);
              }))));
}

Widget buildPostCard(BuildContext context, Post post, int index) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(post.from.pic),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [Text(post.from.fullname)],
          )
        ]),
        Row(children: [
          Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width - 30,
              child: Text(post.message))
        ]),
        Row(children: [
          if (post.image != null)
            Expanded(
                child: Image.asset(post.image.toString(),
                    height: MediaQuery.of(context).size.height / 2))
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
              child: GetBuilder<PostsController>(
                  builder: (pc) =>
                      Text('Likes: ' + pc.posts[index].likesCount.toString())),
              onPressed: () {
                postsController.incrementLikes(index);
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('Comment'),
              onPressed: () {
                Get.to(() => PostDetailsPage(), arguments: {
                  "post": post,
                  "index": index,
                  "is_details_page": true
                });
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ),
  );
}
