// To parse this JSON data, do
//
//     final usersLoginPostResponse = usersLoginPostResponseFromJson(jsonString);

import 'dart:convert';

UsersLoginPostResponse usersLoginPostResponseFromJson(String str) =>
    UsersLoginPostResponse.fromJson(json.decode(str));

String usersLoginPostResponseToJson(UsersLoginPostResponse data) =>
    json.encode(data.toJson());

class UsersLoginPostResponse {
  bool success;
  String message;
  User user;

  UsersLoginPostResponse({
    required this.success,
    required this.message,
    required this.user,
  });

  factory UsersLoginPostResponse.fromJson(Map<String, dynamic> json) =>
      UsersLoginPostResponse(
        success: json["success"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  int userId;
  String firstname;
  String lastName;
  String email;
  String role;
  String wallet;
  String birthday;

  User({
    required this.userId,
    required this.firstname,
    required this.lastName,
    required this.email,
    required this.role,
    required this.wallet,
    required this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    firstname: json["Firstname"],
    lastName: json["LastName"],
    email: json["email"],
    role: json["role"],
    wallet: json["wallet"],
    birthday: json["birthday"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "Firstname": firstname,
    "LastName": lastName,
    "email": email,
    "role": role,
    "wallet": wallet,
    "birthday": birthday,
  };
}
