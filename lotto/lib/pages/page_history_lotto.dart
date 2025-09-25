import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/๊User_claim_lotto_res.dart';

class PageHistoryLotto extends StatefulWidget {
  final int idx;
  const PageHistoryLotto({super.key, required this.idx});

  @override
  State<PageHistoryLotto> createState() => _PageHistoryLottoState();
}

class _PageHistoryLottoState extends State<PageHistoryLotto> {
  late Future<void> loadData;

  List<ResLottoCkeckLotto> lottoHistory = [];
  List<ResLottoCkeckLotto> filteredHistory = [];

  String filter = "ทั้งหมด"; // ตัวกรอง
  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      loadData = loadHistory();
    });
  }

  Future<void> loadHistory() async {
    try {
      var res = await http.get(
        Uri.parse('$url/user/checkLotto?user_id=${widget.idx}'),
      );
      log(res.body);
      lottoHistory = resLottoCkeckLottoFromJson(res.body);
      applyFilter();
    } catch (e) {
      log("Error: $e");
    }
  }

  void applyFilter() {
    setState(() {
      if (filter == "ทั้งหมด") {
        filteredHistory = lottoHistory;
      } else if (filter == "ถูกรางวัล") {
        filteredHistory = lottoHistory.where((e) => e.isWinner).toList();
      } else if (filter == "ไม่ถูกรางวัล") {
        filteredHistory = lottoHistory.where((e) => !e.isWinner).toList();
      }
    });
  }

  Widget buildFilterButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor:
              filter == text ? const Color(0xFFD10922) : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            filter = text;
            applyFilter();
          });
        },
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD10922),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('ประวัติการถูกรางวัล', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // แถบ Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildFilterButton("ทั้งหมด"),
                  buildFilterButton("ถูกรางวัล"),
                  buildFilterButton("ไม่ถูกรางวัล"),
                ],
              ),
            ),
          ),

          // แสดงรายการ
          Expanded(
            child: FutureBuilder(
              future: loadData,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (filteredHistory.isEmpty) {
                  return const Center(child: Text('ไม่พบข้อมูลประวัติ'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  itemCount: filteredHistory.length,
                  itemBuilder: (context, i) {
                    final lotto = filteredHistory[i];
                    
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: Center(
                        child: Card(
                          color: Colors.white,
                          child: Stack(
                        children: [
                          Image.asset("assets/images/lotto.png"),
                          Positioned(
                            left: 195,
                            top: 15,
                            child: Container(
                              width: 155,
                              height: 40,
                              color: Colors.grey,
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

                            // วันที่ (ถ้ามี)
                            // Positioned(
                            //   left: 200,
                            //   top: 65,
                            //   child: Text(
                            //     lotto.date ?? "-", // ถ้าไม่มี field date ต้องแก้ตาม model จริง
                            //     style: const TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ),
                          ],
                          ),
                        ),
                        ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
