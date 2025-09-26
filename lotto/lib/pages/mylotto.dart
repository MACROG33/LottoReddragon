import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/User_lotto_me_res.dart';

class PageLottoTicketScreen extends StatefulWidget {
  int idx = 0;
  PageLottoTicketScreen({super.key, required this.idx});

  @override
  State<PageLottoTicketScreen> createState() => _PageLottoTicketScreenState();
}

class _PageLottoTicketScreenState extends State<PageLottoTicketScreen> {
  late Future<void> loadData;
  String? selectedItem;
  List<ResLottoMeLotto> lottoGetPes = [];
  List<ResLottoMeLotto> setloadData = [];
  String url = '';
  int countLotto = 0;
  bool iscount = false;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th_TH', null); // เรียกครั้งเดียว
    loadData = _initConfigAndLoadData();
  }

  Future<void> _initConfigAndLoadData() async {
    final config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    await getloaddate();
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
          child: Text('สลากของฉัน', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFFD10922),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (lottoGetPes.isEmpty) {
              return const Center(child: Text('ไม่พบข้อมูลสลาก'));
            }
            final width = MediaQuery.of(context).size.width;
            final height = MediaQuery.of(context).size.height;
            return Column(
              children: List.generate(lottoGetPes.length, (i) {
                final lotto = lottoGetPes[i];

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
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              child: Image.asset('assets/images/lotto.png'),
                            ),
                          ),
                          // กล่องตกแต่ง
                          Positioned(
                            left: width * 0.40,
                            top: height * 0.02,
                            child: Container(
                              width: width * 0.33,
                              height: height * 0.06,
                              color: Colors.grey,
                            ),
                          ),
                          Positioned(
                            left: width * 0.40,
                            top: height * 0.09,
                            child: Container(
                              width: width * 0.33,
                              height: height * 0.025,
                              color: Colors.grey,
                            ),
                          ),
                          Positioned(
                            left: width * 0.08,
                            top: height * 0.15,
                            child: Container(
                              width: width * 0.18,
                              height: height * 0.08,
                              color: Colors.grey,
                            ),
                          ),
                          // เลขสลาก
                          Positioned(
                            left: width * 0.42,
                            top: height * 0.02,
                            child: Text(
                              lotto.lottoNumber.split('').join(' '),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // วันที่
                          Positioned(
                            left: width * 0.42,
                            top: height * 0.09,
                            child: Text(
                              "วันที่ $formattedDate",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // ราคา
                          Positioned(
                            left: width * 0.13,
                            top: height * 0.15,
                            child: Text(
                              "${double.parse(lotto.priceLotto).toInt()}\nบาท",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
                              // วันที่
                              Positioned(
                                left: 200,
                                top: 65,
                                child: Text(
                                  "วันที่ $formattedDate",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // ราคา
                              Positioned(
                                left: 40,
                                top: 115,
                                child: Text(
                                  "${double.parse(lotto.priceLotto).toInt()}\nบาท",
                                  style: const TextStyle(
                                    fontSize: 20,
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
    );
  }

  Future<void> getloaddate() async {
    try {
      var res = await http.get(Uri.parse('$url/user/lottoMe?id=${widget.idx}'));

      lottoGetPes = resLottoMeLottoFromJson(res.body);
      setloadData = lottoGetPes;
      countLotto = lottoGetPes.length;
      if (lottoGetPes.isNotEmpty) {
        countLotto = lottoGetPes.length;
      } else {
        iscount = true;
        countLotto = 0;
      }
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }
}
