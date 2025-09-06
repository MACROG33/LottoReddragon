// To parse this JSON data, do
//
//     final usersRegisterPostResRequest = usersRegisterPostResRequestFromJson(jsonString);

import 'dart:convert';

UsersRegisterPostResRequest usersRegisterPostResRequestFromJson(String str) =>
    UsersRegisterPostResRequest.fromJson(json.decode(str));

String usersRegisterPostResRequestToJson(UsersRegisterPostResRequest data) =>
    json.encode(data.toJson());

class UsersRegisterPostResRequest {
  String firstname;
  String lastName;
  String email;
  String password;
  double wallet;
  DateTime birthday;

  UsersRegisterPostResRequest({
    required this.firstname,
    required this.lastName,
    required this.email,
    required this.password,
    required this.wallet,
    required this.birthday,
  });

  factory UsersRegisterPostResRequest.fromJson(Map<String, dynamic> json) =>
      UsersRegisterPostResRequest(
        firstname: json["Firstname"],
        lastName: json["LastName"],
        email: json["email"],
        password: json["password"],
        wallet: json["wallet"]?.toDouble(),
        birthday: DateTime.parse(json["birthday"]),
      );

  Map<String, dynamic> toJson() => {
    "Firstname": firstname,
    "LastName": lastName,
    "email": email,
    "password": password,
    "wallet": wallet,
    "birthday":
        "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
  };
}
