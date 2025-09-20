import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/model/response/lotto_all_get_Res.dart';
import 'package:lotto/pages/home.dart';
import 'package:lotto/pages/info.dart';

class PageSearchLotto extends StatefulWidget {
  const PageSearchLotto({super.key});

  @override
  State<PageSearchLotto> createState() => _PageSearchLottoState();
}

class _PageSearchLottoState extends State<PageSearchLotto> {
  // ช่องกรอกตัวเลข 6 หลัก
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  int selectedIndex = 1;
  String url = '';
  List<GetLottoRes> lottoGetPes = [];
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = Configuration.getConfig().then((config) async {
      await initializeDateFormatting('th_TH', null);
      url = config['apiEndpoint'];

      return getloaddate();
    });
    loadData = getloaddate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD10934), Color(0xFFD10934), Colors.white],
                stops: [0.0, 0.165, 0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    'assets/images/logo_lotto.png',
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'ค้นหาสลากกินแบ่งรัฐบาล',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD10922),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldRow(),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: lottoSearch,
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFD10922),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('ค้นหาสลากกินแบ่งรัฐบาล'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    "ใบสลากทั้งหมด",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD10922),
                    ),
                  ),
                ),

                /// แสดงข้อมูลจาก backend รอ loadData
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
                        final date = DateTime.parse(lotto.dateLotto);
                        final buddhistYear = date.year + 543;
                        final dayMonth = DateFormat(
                          'd MMMM',
                          'th_TH',
                        ).format(date);
                        final formattedDate = '$dayMonth $buddhistYear';

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 3,
                              child: Stack(
                                children: [
                                  Image.asset("assets/images/lotto.png"),
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
                                  // ปุ่มซื้อ
                                  Positioned(
                                    right: 16,
                                    bottom: 16,
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Color(0xFFD10922),
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () => buylotto(
                                        lotto.lottoTicketId.toString(),
                                      ),
                                      child: const Text("ซื้อ"),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'ซื้อสลาก',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ฉัน'),
        ],
      ),
    );
  }

  void buylotto(String lotto) {
    log(lotto);
  }

  Widget TextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: const InputDecoration(
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

  Future<void> lottoSearch() async {
    String lotto = controllers.map((c) => c.text).join();

    log(lotto);

    try {
      var res = await http.get(
        Uri.parse('$url/lotto/search/fields?lotto_name=$lotto'),
      );
      lottoGetPes = getLottoResFromJson(res.body);

      setState(() {
        lottoGetPes = lottoGetPes;
      });

      log(lottoGetPes.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getloaddate() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];
      log(url);
      var res = await http.get(Uri.parse('$url/lotto/showall'));
      final data = getLottoResFromJson(res.body);
      setState(() {
        lottoGetPes = data;
      });
      log(lottoGetPes.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
