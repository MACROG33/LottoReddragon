import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/User_lotto_me_res.dart';

class PageLottoTicketScreen extends StatefulWidget {
  final int idx;
  const PageLottoTicketScreen({super.key, required this.idx});

  @override
  State<PageLottoTicketScreen> createState() => _PageLottoTicketScreenState();
}

class _PageLottoTicketScreenState extends State<PageLottoTicketScreen> {
  late Future<void> loadData;
  List<ResLottoMeLotto> lottoGetPes = [];
  String url = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th_TH', null);
    loadData = _initConfigAndLoadData();
  }

  Future<void> _initConfigAndLoadData() async {
    final config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    await getloaddate();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('สลากของฉัน', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFD10922),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (lottoGetPes.isEmpty) {
            return const Center(child: Text('ไม่พบข้อมูลสลาก'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: lottoGetPes.length,
            itemBuilder: (context, i) {
              final lotto = lottoGetPes[i];

              // แปลงวันที่ + พ.ศ.
              String formattedDate;
              try {
                final date = DateTime.parse(lotto.dateLotto);
                final buddhistYear = date.year + 543;
                final dayMonth = DateFormat('d MMMM', 'th_TH').format(date);
                formattedDate = '$dayMonth $buddhistYear';
              } catch (e) {
                log('Error parsing date: $e');
                formattedDate = lotto.dateLotto;
              }

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ภาพสลาก
                      SizedBox(
                        width: screenWidth * 0.4,
                        child: Image.asset('assets/images/lotto.png',
                            fit: BoxFit.cover),
                      ),

                      // ข้อมูลสลาก
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lotto.lottoNumber.split('').join(' '),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "วันที่ $formattedDate",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: screenWidth * 0.2,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "${double.parse(lotto.priceLotto).toInt()}\nบาท",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getloaddate() async {
    try {
      log("${widget.idx} $url");
      var res = await http.get(Uri.parse('$url/user/lottoMe?id=${widget.idx}'));
      log(res.body);
      lottoGetPes = resLottoMeLottoFromJson(res.body);
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }
}
