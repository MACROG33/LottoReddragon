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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: Text('สุ่มรางวัล', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFFD10922),
      ),
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
                          padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
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
                  height: 1000,
                  child: ListView(
                    children: getDrawslotto
                        .map(
                          (trip) => Card(
                            color: Colors.white,
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
                              child: Column(
                                children: [
                                  Text(
                                    trip.reward ??
                                        "", // หรือ trip.Reward แล้วแต่ model
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD10922),
                                    ),
                                  ),

                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                    height: 20,
                                    indent: 40,
                                    endIndent: 40,
                                  ),
                                  Text(
                                    trip.prize.toString(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
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

  Future<void> drawLottoWinners({bool onlySold = false}) async {
    try {
      final uri = Uri.parse("$url/admin/generate/draws?onlySold=$onlySold");
      final res = await http.post(uri);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final winners = data['winners'];
        print("✅ รางวัลทั้ง 5: $winners");
        setState(() {
          loadData = loadDataShow();
        });
      } else {
        print(" สุ่มรางวัลไม่สำเร็จ: ${res.body}");
      }
    } catch (e) {
      print("Exception: $e");
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
