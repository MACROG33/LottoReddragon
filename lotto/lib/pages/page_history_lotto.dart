import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/User_lotto_me_res.dart';
import 'package:lotto/model/response/๊User_claim_lotto_res.dart';

class PageHistoryLotto extends StatefulWidget {
  final int idx;
  const PageHistoryLotto({super.key, required this.idx});

  @override
  State<PageHistoryLotto> createState() => _PageHistoryLottoState();
}

class _PageHistoryLottoState extends State<PageHistoryLotto> {
  late Future<void> loadData;
  String? selectedItem;
  List<ResLottoMeLotto> lottoGetPes = [];
  List<ResLottoMeLotto> setloadData = [];

  List<ResLottoCkeckLotto> lottoHistory = [];
  List<ResLottoCkeckLotto> filteredHistory = [];

  String filter = "ทั้งหมด";
  String url = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th_TH', null);
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      setState(() {
        loadData = loadHistory();
        loadData = getloaddate();
      });
    });
  }

  Future<void> loadHistory() async {
    try {
      var res = await http.get(
        Uri.parse('$url/user/checkLotto?user_id=${widget.idx}'),
      );

      lottoHistory = resLottoCkeckLottoFromJson(res.body);
      applyFilter();
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> getloaddate() async {
    try {
      log("${widget.idx} $url");

      var res = await http.get(Uri.parse('$url/user/lottoMe?id=${widget.idx}'));
      log(res.body);
      lottoGetPes = resLottoMeLottoFromJson(res.body);
      setloadData = lottoGetPes;

      if (!mounted) return; // ป้องกัน widget ถูก dispose แล้ว
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  String getPrizeAmount(String? reward) {
    final Map<String, String> prizeTable = {
      'รางวัลที่1': '6,000,000',
      'รางวัลที่2': '200,000',
      'รางวัลที่3': '80,000',
      'รางวัลเลขท้าย 3 ตัว': '4,000',
      'รางวัลเลขท้าย 2 ตัว': '2,000',
    };
    return prizeTable[reward] ?? "-";
  }

  String formatDateThai(String? dateStr) {
    if (dateStr == null) return "วันที่ไม่ระบุ";
    try {
      final date = DateTime.parse(dateStr);
      final buddhistYear = date.year + 543;
      final dayMonth = DateFormat('d MMMM', 'th_TH').format(date);
      return "$dayMonth $buddhistYear";
    } catch (e) {
      log("Error parsing date: $e");
      return dateStr;
    }
  }

  String formatPrice(String? priceStr) {
    if (priceStr == null) return "-";
    try {
      double price = double.parse(priceStr);
      return price.toInt().toString();
    } catch (e) {
      return priceStr;
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
          backgroundColor: filter == text
              ? const Color(0xFFD10922)
              : Colors.grey,
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
        title: const Text(
          'ประวัติการถูกรางวัล',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                      final item = filteredHistory[i];
                      final item2 = lottoGetPes[i];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Card(
                            color: const Color(0xFFD9D9D9),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
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
                                      ),
                                    ),
                                    Positioned(
                                      left: 200,
                                      top: 65,
                                      child: Text(
                                        formatDateThai(item2.dateLotto),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 205,
                                      top: 15,
                                      child: Text(
                                        item.lottoNumber ?? "-",
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 40,
                                      top: 115,
                                      child: Text(
                                        "${formatPrice(item2.priceLotto)}\nบาท",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        item.isWinner
                                            ? item.reward ?? "ถูกรางวัล"
                                            : "ไม่ถูกรางวัล",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: item.isWinner
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      if (item.isWinner)
                                        Text(
                                          "จำนวนเงิน ${getPrizeAmount(item.reward)} บาท",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
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
      ),
    );
  }
}
