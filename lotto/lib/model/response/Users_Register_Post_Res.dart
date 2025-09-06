// To parse this JSON data, do
//
//     final usersRegisterPostResResponse = usersRegisterPostResResponseFromJson(jsonString);

import 'dart:convert';

UsersRegisterPostResResponse usersRegisterPostResResponseFromJson(String str) =>
    UsersRegisterPostResResponse.fromJson(json.decode(str));

String usersRegisterPostResResponseToJson(UsersRegisterPostResResponse data) =>
    json.encode(data.toJson());

class UsersRegisterPostResResponse {
  bool success;
  String message;
  int lottoTicketId;

  UsersRegisterPostResResponse({
    required this.success,
    required this.message,
    required this.lottoTicketId,
  });

  factory UsersRegisterPostResResponse.fromJson(Map<String, dynamic> json) =>
      UsersRegisterPostResResponse(
        success: json["success"],
        message: json["message"],
        lottoTicketId: json["lottoTicketId"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "lottoTicketId": lottoTicketId,
  };
}
