// To parse this JSON data, do
//
//     final getDrowsLottoRes = getDrowsLottoResFromJson(jsonString);

import 'dart:convert';

List<GetDrowsLottoRes> getDrowsLottoResFromJson(String str) =>
    List<GetDrowsLottoRes>.from(
      json.decode(str).map((x) => GetDrowsLottoRes.fromJson(x)),
    );

String getDrowsLottoResToJson(List<GetDrowsLottoRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDrowsLottoRes {
  int drawsLottoId;
  String prize;
  String reward;
  String date;

  GetDrowsLottoRes({
    required this.drawsLottoId,
    required this.prize,
    required this.reward,
    required this.date,
  });

  factory GetDrowsLottoRes.fromJson(Map<String, dynamic> json) =>
      GetDrowsLottoRes(
        drawsLottoId: json["draws_lotto_id"],
        prize: json["Prize"],
        reward: json["Reward"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
    "draws_lotto_id": drawsLottoId,
    "Prize": prize,
    "Reward": reward,
    "date": date,
  };
}
