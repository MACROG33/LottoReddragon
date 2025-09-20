import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto/pages/info.dart';
import 'package:lotto/pages/page_search_lotto.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(209, 9, 34, 1)),
      body: SingleChildScrollView(
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
                  height: 500, // ความสูงของ Card
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      buildPrizeCard("รางวัลที่ 1", "666666", "6,000,000 บาท"),
                      SizedBox(width: 16),
                      buildPrizeCard("รางวัลที่ 2", "123456", "2,000,000 บาท"),
                      SizedBox(width: 16),
                      buildPrizeCard("รางวัลที่ 3", "654321", "1,000,000 บาท"),
                    ],
                  ),
                ),
              ),
            ],
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
              MaterialPageRoute(builder: (context) => PageSearchLotto()),
            );
          } else if (value == 0) {
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
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
          width: 40,
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

  // ignore: non_constant_identifier_names
  void LottoCheck() {
    String lotto = controllers.map((c) => c.text).join();
    log(lotto);
  }
}
