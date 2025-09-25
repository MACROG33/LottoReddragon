// To parse this JSON data, do
//
//     final resLottoMeLotto = resLottoMeLottoFromJson(jsonString);

import 'dart:convert';

List<ResLottoMeLotto> resLottoMeLottoFromJson(String str) =>
    List<ResLottoMeLotto>.from(
      json.decode(str).map((x) => ResLottoMeLotto.fromJson(x)),
    );

String resLottoMeLottoToJson(List<ResLottoMeLotto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResLottoMeLotto {
  int orderId;
  String firstname;
  String lastName;
  String lottoNumber;
  String priceLotto;
  String dateLotto;

  ResLottoMeLotto({
    required this.orderId,
    required this.firstname,
    required this.lastName,
    required this.lottoNumber,
    required this.priceLotto,
    required this.dateLotto,
  });

  factory ResLottoMeLotto.fromJson(Map<String, dynamic> json) =>
      ResLottoMeLotto(
        orderId: json["order_id"],
        firstname: json["Firstname"],
        lastName: json["LastName"],
        lottoNumber: json["lotto_number"],
        priceLotto: json["price_lotto"],
        dateLotto: json["date_lotto"],
      );

  bool? get isWinner => null;

  get reward => null;

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "Firstname": firstname,
    "LastName": lastName,
    "lotto_number": lottoNumber,
    "price_lotto": priceLotto,
    "date_lotto": dateLotto,
  };
}
