// To parse this JSON data, do
//
//     final getLottoRes = getLottoResFromJson(jsonString);

import 'dart:convert';

List<GetLottoRes> getLottoResFromJson(String str) => List<GetLottoRes>.from(
  json.decode(str).map((x) => GetLottoRes.fromJson(x)),
);

String getLottoResToJson(List<GetLottoRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetLottoRes {
  int lottoTicketId;
  String lottoNumber;
  String priceLotto;
  String dateLotto;
  String lottoStatus;
  int? orderId;

  GetLottoRes({
    required this.lottoTicketId,
    required this.lottoNumber,
    required this.priceLotto,
    required this.dateLotto,
    required this.lottoStatus,
    required this.orderId,
  });

  factory GetLottoRes.fromJson(Map<String, dynamic> json) => GetLottoRes(
    lottoTicketId: json["lottoTicket_id"],
    lottoNumber: json["lotto_number"],
    priceLotto: json["price_lotto"],
    dateLotto: json["date_lotto"],
    lottoStatus: json["lotto_status"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "lottoTicket_id": lottoTicketId,
    "lotto_number": lottoNumber,
    "price_lotto": priceLotto,
    "date_lotto": dateLotto,
    "lotto_status": lottoStatus,
    "order_id": orderId,
  };
}
