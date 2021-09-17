import 'dart:convert';

import 'package:sshare/models/user.dart';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
    Comment(
        this.id,
        this.from,
        this.message
    );

    int id;
    User from;
    String message;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        json["id"],
        User.fromJson(json["from"]),
        json["message"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "message": message,
    };
}