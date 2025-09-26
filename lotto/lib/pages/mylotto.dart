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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                iscount
                    ? "คุณยังไม่ได้ซื้อลอตเตอรี่"
                    : 'จำนวนสลาก ${countLotto} ใบ',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

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

                      // แปลงวันที่ + พ.ศ.
                      String formattedDate = '';
                      try {
                        final date = DateTime.parse(lotto.dateLotto);
                        final buddhistYear = date.year + 543;
                        final dayMonth = DateFormat(
                          'd MMMM',
                          'th_TH',
                        ).format(date);
                        formattedDate = '$dayMonth $buddhistYear';
                      } catch (e) {
                        log('Error parsing date: $e');
                        formattedDate = lotto.dateLotto;
                      }
                      final width = MediaQuery.of(context).size.width;
                      final height = MediaQuery.of(context).size.height;

                      return SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Center(
                            child: Card(
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  InkWell(
                                    child: Image.asset(
                                      'assets/images/lotto.png',
                                    ),
                                  ),
                                  // กล่องตกแต่ง
                                  Positioned(
                                    left: width * 0.49,
                                    top: height * 0.02,
                                    child: Container(
                                      width: width * 0.40,
                                      height: height * 0.05,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Positioned(
                                    left: width * 0.49,
                                    top: height * 0.08,
                                    child: Container(
                                      width: width * 0.40,
                                      height: height * 0.026,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Positioned(
                                    left: width * 0.08,
                                    top: height * 0.13,
                                    child: Container(
                                      width: width * 0.18,
                                      height: height * 0.08,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  // เลขสลาก
                                  Positioned(
                                    left: width * 0.50,
                                    top: height * 0.02,
                                    child: Text(
                                      lotto.lottoNumber.split('').join(' '),
                                      style: TextStyle(
                                        fontSize: width * 0.07,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // วันที่
                                  Positioned(
                                    left: width * 0.49,
                                    top: height * 0.08,
                                    child: Text(
                                      "วันที่ $formattedDate",
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // ราคา
                                  Positioned(
                                    left: width * 0.13,
                                    top: height * 0.13,
                                    child: Text(
                                      "${double.parse(lotto.priceLotto).toInt()}\nบาท",
                                      style: TextStyle(
                                        fontSize: width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
