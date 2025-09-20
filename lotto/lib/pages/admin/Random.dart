import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/drows_lotto_get_Res.dart';
import 'package:lotto/model/response/lotto_all_get_Res.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  List<GetDrowsLottoRes> getDrawslotto = [];

  late Future<void> loadData;
  String? selectedItem;
  String url = '';
  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
    loadData = loadDataShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RandomPage")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.white,
              shadowColor: Colors.black,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // ให้ Card ขนาดพอดีกับเนื้อหา
                  children: [
                    const Text(
                      "สุ่มฉลากกินแบ่งรัฐบาล",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldRow(),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFFD10934),
                            ),
                            onPressed: drawLottoWinners,
                            child: const Text(
                              "สุ่มเลขทั้งหมด",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFFD10934),
                            ),
                            onPressed: () => drawLottoWinners(onlySold: true),
                            child: const Text(
                              "สุ่มเลขที่ถูกชื้อไปแล้ว",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            FutureBuilder(
              future: loadData,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 400,
                  child: ListView(
                    children: getDrawslotto
                        .map(
                          (trip) => Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Text(
                                    trip.prize.toString(),
                                  ), // ถ้าเป็น int ต้อง .toString()
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void drawLottoWinners({bool onlySold = false}) async {
    try {
      var res = await http.get(Uri.parse('$url/lotto/showall'));
      List<GetLottoRes> allLotto = getLottoResFromJson(res.body);

      List<GetLottoRes> eligibleLotto = [];

      if (onlySold) {
        eligibleLotto = allLotto.where((l) => l.lottoStatus == 'sold').toList();
      } else {
        eligibleLotto = allLotto;
      }

      if (eligibleLotto.length < 3) {
        log('จำนวนสลากไม่เพียงพอสำหรับสุ่มรางวัลที่ 1,2,3');
        return;
      }

      Random random = Random();
      Set<String> selectedNumbers = {}; // เก็บเลขสลากที่ถูกเลือกแล้ว

      // ฟังก์ชันสุ่มเลขสลากโดยไม่ซ้ำ
      GetLottoRes pickUniqueLotto() {
        GetLottoRes lotto;
        do {
          lotto = eligibleLotto[random.nextInt(eligibleLotto.length)];
        } while (selectedNumbers.contains(lotto.lottoNumber));
        selectedNumbers.add(lotto.lottoNumber);
        return lotto;
      }

      GetLottoRes firstPrize = pickUniqueLotto();
      GetLottoRes secondPrize = pickUniqueLotto();
      GetLottoRes thirdPrize = pickUniqueLotto();

      GetLottoRes last2Digits = pickUniqueLotto();

      String last3Digits = firstPrize.lottoNumber.substring(3, 6);
      String last2Digitsget = last2Digits.lottoNumber.substring(4, 6);

      Map<String, String> winners = {
        'รางวัลที่1': firstPrize.lottoNumber,
        'รางวัลที่2': secondPrize.lottoNumber,
        'รางวัลที่3': thirdPrize.lottoNumber,
        'รางวัลเลขท้าย 3 ตัว': last3Digits,
        'รางวัลเลขท้าย 2 ตัว': last2Digitsget,
      };
      try {
        // แปลง winners เป็น List<Map>
        List<Map<String, String>> jsonList = [];
        DateTime now = DateTime.now();
        String dateLotto = now.toIso8601String().split("T")[0];
        winners.forEach((key, value) {
          jsonList.add({"prize": value, "Reward": key, "date": dateLotto});
        });

        log(url);

        // delete ทุก Colum ก่อนลง databass
        http
            .delete(Uri.parse("$url/lotto/draws/delete"))
            .then((value) {
              log(value.body);
            })
            .catchError((err) {
              log(err.toString());
            });

        // Insert To DB  Draws
        http
            .post(
              Uri.parse("$url/lotto/draws"),
              headers: {"Content-Type": "application/json; charset=utf-8"},
              body: jsonEncode(jsonList),
            )
            .then((value) {
              log(value.body);
              setState(() {
                loadData = loadDataShow();
              });
            })
            .catchError((onError) {
              log(onError.toString());
            });
      } catch (e) {
        log("Error: $e");
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Widget TextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          width: 40,

          margin: EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            enabled: false,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 5) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }

              if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }

  Widget buildPrizeCard(String title, String number, String prize) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              number,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("รางวัลละ $prize", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Future<void> loadDataShow() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];
      var res = await http.get(Uri.parse('$url/lotto/getdraws'));
      log(res.body);
      getDrawslotto = getDrowsLottoResFromJson(res.body);
      log(getDrawslotto.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
