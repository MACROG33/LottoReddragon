import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/drows_lotto_get_Res.dart';
import 'package:lotto/pages/info.dart';
import 'package:lotto/pages/page_search_lotto.dart';

class HomePage extends StatefulWidget {
  int idx = 0;
  HomePage({super.key, required this.idx});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  int selectedIndex = 0;

  List<GetDrowsLottoRes> latestDraws = []; // เก็บรางวัลล่าสุด
  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) async {
      url = config['apiEndpoint'];
      var res = await http.get(Uri.parse('$url/lotto/getdraws'));
      setState(() {
        latestDraws = getDrowsLottoResFromJson(res.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD10934), Color(0xFFD10934), Colors.white],
                stops: [0.0, 0.3, 0.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/lotto-Photoroom.png',
                    width: 200,
                  ),
                ),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "ตรวจผลสลากกินแบ่งรัฐบาล",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldRow(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFFD10934),
                            ),
                            onPressed: LottoCheck,
                            child: const Text(
                              "ตรวจสลาก ของคุณ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),

                  child: SizedBox(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        buildFlashSaleCard('assets/images/flashsale.jpg'),
                        SizedBox(width: 16),
                        buildFlashSaleCard('assets/images/flashsale.jpg'),
                        SizedBox(width: 16),
                        buildFlashSaleCard('assets/images/flashsale.jpg'),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("เงินการถูกรางวัล", style: TextStyle(fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: latestDraws.length,
                      itemBuilder: (context, index) {
                        final draw = latestDraws[index];

                        String prizeAmount;
                        if (draw.reward == 'รางวัลที่1') {
                          prizeAmount = '6,000,000 บาท';
                        } else if (draw.reward == 'รางวัลที่2') {
                          prizeAmount = '200,000 บาท';
                        } else if (draw.reward == 'รางวัลที่3') {
                          prizeAmount = '80,000 บาท';
                        } else if (draw.reward == 'รางวัลเลขท้าย 3 ตัว') {
                          prizeAmount = '4,000 บาท';
                        } else if (draw.reward == 'รางวัลเลขท้าย 2 ตัว') {
                          prizeAmount = '2,000 บาท';
                        } else {
                          prizeAmount = '-';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: buildPrizeCard(
                            draw.reward ?? '',
                            draw.prize.toString(),
                            prizeAmount,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });

          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageSearchLotto(idx: widget.idx),
              ),
            );
          } else if (value == 0) {
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(idx: widget.idx),
              ),
            );
          }
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าหลัก"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "ซื้อสลาก",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "ฉัน"),
        ],
      ),
    );
  }

  Widget buildFlashSaleCard(String imagePath) {
    return SizedBox(
      width: 300,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
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

  // ignore: non_constant_identifier_names
  Widget TextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.1,
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
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

  void showLottoCheck({
    required bool isWin,
    required String message,
    required String lotto,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isWin
                  ? 'assets/images/winlotto.png'
                  : 'assets/images/loselotto.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 8),
            Text(
              isWin ? 'ยินดีด้วย!' : 'เสียใจด้วย!',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              message, // ข้อความจาก API
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isWin ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'เลขที่ตรวจ: $lotto',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  Future<void> LottoCheck() async {
    String lotto = controllers.map((c) => c.text).join();
    log(lotto);
    log(url);

    try {
      log(widget.idx.toString());

      // Send lotto as query parameter or in body depending on API requirement
      final res = await http.get(
        Uri.parse('$url/lotto/draws/check?lotto=$lotto&idx=${widget.idx}'),
      );

      if (res.statusCode == 200) {
        log('Response: ${res.body}');
        var data = jsonDecode(res.body);

        bool isWin = data['isWinner'] ?? false;
        String message = data['message'] ?? '';
        showLottoCheck(isWin: isWin, message: message, lotto: lotto);
      } else {
        log('Error: ${res.statusCode}');
      }
    } catch (e) {
      log('Exception: $e');
    }
  }
}
