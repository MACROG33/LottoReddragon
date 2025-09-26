// To parse this JSON data, do
//
//     final resLottoCkeckLotto = resLottoCkeckLottoFromJson(jsonString);

import 'dart:convert';

List<ResLottoCkeckLotto> resLottoCkeckLottoFromJson(String str) =>
    List<ResLottoCkeckLotto>.from(
      json.decode(str).map((x) => ResLottoCkeckLotto.fromJson(x)),
    );

String resLottoCkeckLottoToJson(List<ResLottoCkeckLotto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResLottoCkeckLotto {
  int userId;
  String firstname;
  String lastname;
  String lottoNumber;
  String lottoStatus;
  bool isWinner;
  dynamic reward;

  ResLottoCkeckLotto({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.lottoNumber,
    required this.lottoStatus,
    required this.isWinner,
    required this.reward,
  });

  factory ResLottoCkeckLotto.fromJson(Map<String, dynamic> json) =>
      ResLottoCkeckLotto(
        userId: json["user_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        lottoNumber: json["lotto_number"],
        lottoStatus: json["lotto_status"],
        isWinner: json["isWinner"],
        reward: json["reward"],
      );

  get date => null;

  get price => null;

  get prizeAmount => null;

  String? get priceLotto => null;

  String? get dateLotto => null;

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "firstname": firstname,
    "lastname": lastname,
    "lotto_number": lottoNumber,
    "lotto_status": lottoStatus,
    "isWinner": isWinner,
    "reward": reward,
  };
}
