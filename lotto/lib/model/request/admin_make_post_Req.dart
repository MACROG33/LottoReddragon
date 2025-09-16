// To parse this JSON data, do
//
//     final adminMakeLottoReq = adminMakeLottoReqFromJson(jsonString);

import 'dart:convert';

AdminMakeLottoReq adminMakeLottoReqFromJson(String str) =>
    AdminMakeLottoReq.fromJson(json.decode(str));

String adminMakeLottoReqToJson(AdminMakeLottoReq data) =>
    json.encode(data.toJson());

class AdminMakeLottoReq {
  String lottoNumber;
  int priceLotto;
  String dateLotto;

  AdminMakeLottoReq({
    required this.lottoNumber,
    required this.priceLotto,
    required this.dateLotto,
  });

  factory AdminMakeLottoReq.fromJson(Map<String, dynamic> json) =>
      AdminMakeLottoReq(
        lottoNumber: json["lotto_number"],
        priceLotto: json["price_lotto"],
        dateLotto: json["date_lotto"],
      );

  Map<String, dynamic> toJson() => {
    "lotto_number": lottoNumber,
    "price_lotto": priceLotto,
    "date_lotto": dateLotto,
  };
}
