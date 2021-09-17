import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sshare/components/post_components.dart';
import 'package:sshare/controllers/posts_controller.dart';
import 'package:sshare/controllers/users_controller.dart';
import 'package:sshare/models/comment.dart';
import 'package:sshare/models/post.dart';
import 'package:sshare/services/validators.dart';

class PostDetailsPage extends StatefulWidget {
  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  UsersController usersController = Get.find();
  PostsController postsController = Get.find();
  Post post = Get.arguments["post"];
  int postIndex = Get.arguments["index"];
  String newComment = "";

  var _addCommentFormKey = GlobalKey<FormState>();
  TextEditingController newCommentController = TextEditingController();

  void updateNewComment() {
    newComment = newCommentController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Post")),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              buildPostCard(context, post, postIndex),
              Card(
                  child: Column(
                children: [
                  Form(
                    key: _addCommentFormKey,
                    child: TextFormField(
                      validator: (value) {
                        return minLengthValidator(value, 3);
                      },
                      controller: newCommentController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your comment',
                          fillColor: Colors.white),
                      onChanged: (String text) {
                        updateNewComment();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text('Post comment'),
                        onPressed: () {
                          if (_addCommentFormKey.currentState!.validate()){
                            postsController.addComment(
                                post.id,
                                Comment(
                                    0, usersController.loggedUser, newComment));
                            newCommentController.text = "";
                            updateNewComment();
                          }
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ],
              )),
              GetBuilder<PostsController>(builder: (pc) {
                Post thisPost = pc.posts.firstWhere((p) => p.id == post.id);
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    itemCount: post.comments.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          post.comments[index].from.pic),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          post.comments[index].from.fullname),
                                    ),
                                  ]),
                                  Row(children: [
                                    Container(
                                        padding: EdgeInsets.all(10.0),
                                        width: MediaQuery.of(context).size.width-30,
                                        child:
                                            Text(post.comments[index].message))
                                  ]),
                                ],
                              )));
                    },
                  ),
                );
              }),
            ],
          ),
        ));
  }
}
