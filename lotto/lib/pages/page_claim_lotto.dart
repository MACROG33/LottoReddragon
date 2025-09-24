import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/%E0%B9%8AUser_claim_lotto_res.dart';

class PageClaimLotto extends StatefulWidget {
  int idx = 0;
  PageClaimLotto({super.key, required this.idx});

  @override
  State<PageClaimLotto> createState() => _PageClaimLottoState();
}

class _PageClaimLottoState extends State<PageClaimLotto> {
  late Future<void> loadData;

  List<ResLottoCkeckLotto> lottoGetPes = [];
  List<ResLottoCkeckLotto> setloadData = [];
  String url = '';
  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      loadData = loadDataShow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: Text('ขึ้นเงินรางวัล', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFFD10922),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder(
                future: loadData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (lottoGetPes.isEmpty) {
                    return const Center(child: Text('ไม่พบข้อมูลสลาก'));
                  }

                  return Column(
                    children: List.generate(lottoGetPes.length, (i) {
                      final lotto = lottoGetPes[i];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Card(
                            color: Colors.white,
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () => popUpClaimLotto(
                                    lotto.reward.toString(),
                                    lotto.isWinner,
                                  ),
                                  child: Image.asset('assets/images/lotto.png'),
                                ),

                                // กล่องตกแต่ง
                                Positioned(
                                  left: 195,
                                  top: 15,
                                  child: Container(
                                    width: 155,
                                    height: 40,
                                    color: Colors.grey,
                                  ),
                                ),

                                Positioned(
                                  left: 195,
                                  top: 65,
                                  child: Container(
                                    width: 155,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                Positioned(
                                  left: 25,
                                  top: 115,
                                  child: Container(
                                    width: 70,
                                    height: 60,
                                    color: Colors.grey,
                                    alignment: Alignment.center,
                                    child: Text(
                                      lotto.reward != null
                                          ? lotto.reward.toString()
                                          : "ไม่ถูกรางวัล",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                // เลขสลาก
                                Positioned(
                                  left: 205,
                                  top: 15,
                                  child: Text(
                                    lotto.lottoNumber.split('').join(' '),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popUpClaimLotto(String reward, bool isWinner) {
    if (!isWinner) {
      log("ตั๋วนี้ไม่ถูกรางวัล");
      return;
    }

    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        content: const Text(
          'คุณแน่ใจไหมที่จะขึ้นเงิน',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  Get.back();
                  claimLotto(reward, isWinner);
                  Get.dialog(
                    const AlertDialog(
                      content: Text(
                        "ขึ้นเงินรางวัลสำเร็จ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    barrierDismissible: false,
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Get.back();
                  });
                },
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> loadDataShow() async {
    try {
      var res = await http.get(
        Uri.parse('$url/user/checkLotto?user_id=${widget.idx}'),
      );
      log(res.body);
      lottoGetPes = resLottoCkeckLottoFromJson(res.body);
      setloadData = lottoGetPes;
      log(setloadData.length.toString());
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  void claimLotto(String reward, bool isWinner) async {
    if (!isWinner) {
      log("ตั๋วนี้ไม่ถูกรางวัล");
      return;
    }
    // แปลง reward เป็นจำนวนเงิน
    int prizeMoney = getPrizeMoney(reward);

    log(
      "ถูกรางวัล $reward จำนวนเงิน $prizeMoney บาท " +
          widget.idx.toString() +
          "id",
    );

    try {
      final response = await http.put(
        Uri.parse('$url/user/claim'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"user_id": widget.idx, "amount": prizeMoney}),
      );

      if (response.statusCode == 200) {
        log("ขึ้นเงินรางวัลสำเร็จ: ${response.body}");
      } else {
        log("เกิดข้อผิดพลาด: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      log("ไม่สามารถเรียก API ได้: $e");
    }
  }

  int getPrizeMoney(String reward) {
    switch (reward) {
      case "รางวัลที่1":
        return 6000000;
      case "รางวัลที่2":
        return 200000;
      case "รางวัลที่3":
        return 80000;
      case "รางวัลเลขท้าย 3 ตัว":
        return 4000;
      case "รางวัลเลขท้าย 2 ตัว":
        return 2000;
      default:
        return 0;
    }
  }
}
