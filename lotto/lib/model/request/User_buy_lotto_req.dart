// To parse this JSON data, do
//
//     final reqBuyLotto = reqBuyLottoFromJson(jsonString);

import 'dart:convert';

ReqBuyLotto reqBuyLottoFromJson(String str) =>
    ReqBuyLotto.fromJson(json.decode(str));

String reqBuyLottoToJson(ReqBuyLotto data) => json.encode(data.toJson());

class ReqBuyLotto {
  int userId;
  String lottoNumber;
  double priceLotto;

  ReqBuyLotto({
    required this.userId,
    required this.lottoNumber,
    required this.priceLotto,
  });

  factory ReqBuyLotto.fromJson(Map<String, dynamic> json) => ReqBuyLotto(
    userId: json["user_id"],
    lottoNumber: json["lotto_number"],
    priceLotto: json["price_lotto"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "lotto_number": lottoNumber,
    "price_lotto": priceLotto,
  };
}
