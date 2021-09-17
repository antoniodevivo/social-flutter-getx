import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User(
        this.id,
        this.fullname,
        this.pic,
    );

    int id;
    String fullname;
    String pic;

    factory User.fromJson(Map<String, dynamic> json) => User(
        json["id"],
        json["fullname"],
        json["pic"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "pic": pic,
    };
}