import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';
import 'package:lotto/model/request/admin_make_post_Req.dart';
import 'package:lotto/model/response/lotto_all_get_Res.dart';

class MakePage extends StatefulWidget {
  const MakePage({super.key});

  @override
  State<MakePage> createState() => _MakePageState();
}

class _MakePageState extends State<MakePage> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  TextEditingController controllerCount = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();

  List<GetLottoRes> lottoGetPes = [];
  List<GetLottoRes> setloadData = [];
  late Future<void> loadData;
  String url = '';
  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      loadData = getloaddate();
    });
  }


  // เก็บเลขล็อตโต้ที่สุ่มได้
  List<String> lottoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MakePage")),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "สร้างสลากกินแบ่ง",
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("จำนวน"),
                          SizedBox(
                            width: 70,
                            child: TextField(
                              controller: controllerCount,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Text("ใบ"),
                          SizedBox(width: 16),
                          Text("ราคา"),
                          SizedBox(
                            width: 70,
                            child: TextField(
                              controller: controllerPrice,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Text("บาท"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFFD10934),
                        ),
                        onPressed: makeLotto,
                        child: const Text(
                          "สร้าง",
                          style: TextStyle(color: Colors.white),
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
  // {
  //   "lotto_number": "931233",
  //   "price_lotto": 100.00,
  //   "date_lotto": "2025-09-05"
  // }

  void makeLotto() async {
    if (controllerCount.text.isNotEmpty && controllerPrice.text.isNotEmpty) {
      int count = int.parse(controllerCount.text);
      int price = int.parse(controllerPrice.text);
      Random random = Random();

      Set<String> lottoNumbers = {};

      while (lottoNumbers.length < count) {
        String number = random.nextInt(1000000).toString().padLeft(6, '0');
        lottoNumbers.add(number);
      }

      DateTime now = DateTime.now();
      String dateLotto = now.toIso8601String().split("T")[0];

      //  Make list ของ request objects
      List<AdminMakeLottoReq> reqList = lottoNumbers.map((lottoNumber) {
        return AdminMakeLottoReq(
          lottoNumber: lottoNumber,
          priceLotto: price,
          dateLotto: dateLotto,
        );
      }).toList();
      log(url);
      try {
        try {
          await http
              .post(
                Uri.parse("$url/lotto/insert"),
                headers: {"Content-Type": "application/json; charset=utf-8"},
                body: jsonEncode(reqList.map((e) => e.toJson()).toList()),
              )
              .then((value) {
                log(value.body);
              })
              .catchError((onError) {
                log(onError);
              });
        } catch (error) {
          log("Error: $error");
        }
      } catch (error) {
        log("Error: $error");
      }
    } else {
      log("Error Null");
    }
  }

  Future<void> getloaddate() async {
    try {
      if (url.isEmpty) return; // ป้องกัน url ยังไม่ถูกตั้งค่า
      var res = await http.get(Uri.parse('$url/lotto/showall'));
      log(res.body);
      lottoGetPes = getLottoResFromJson(res.body);
      setloadData = lottoGetPes;

      if (!mounted) return; // ป้องกัน widget ถูก dispose แล้ว
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }
}