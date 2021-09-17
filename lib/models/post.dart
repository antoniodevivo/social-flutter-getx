import 'dart:convert';
import 'package:sshare/models/comment.dart';

import './user.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    Post(
        this.id,
        this.from,
        this.link,
        this.image,
        this.message,
        this.likesCount,
        this.comments,
        this.createdAt,
    );

    int id;
    User from;
    String? link;
    String? image;
    String message;
    int likesCount;
    List<Comment> comments;
    String createdAt;

    factory Post.fromJson(Map<String, dynamic> json) {
      var commentsJson = json["comments"] as List;
      List<Comment> commentsList = commentsJson.map((commentJson) => Comment.fromJson(commentJson)).toList();
      
      return Post(
        json["id"],
        User.fromJson(json["from"]),
        json["link"],
        json["image"],
        json["message"],
        json["likes_count"],
        commentsList,
        json["created_at"],
    );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "from": from.toJson(),
        "link": link,
        "image": image,
        "message": message,
        "likes_count": likesCount,
        "comments": jsonEncode(comments),
        "created_at": createdAt,
    };
}
