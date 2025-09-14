import 'package:flutter/material.dart';
import 'package:lotto/pages/home.dart';
import 'package:lotto/pages/info.dart';

class PageSearchLotto extends StatefulWidget {
  const PageSearchLotto({super.key});

  @override
  State<PageSearchLotto> createState() => _PageSearchLottoState();
}

class _PageSearchLottoState extends State<PageSearchLotto> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BG Gradient ตรึง
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD10934), Color(0xFFD10934), Colors.white],
                stops: [0.0, 0.3, 0.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // เนื้อหาเลื่อน
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 50),
              Center(
                child: Image.asset('assets/images/logo_lotto.png', width: 200),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'ค้นหาสลากกินแบ่งรัฐบาล',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD10922),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldRow(),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFFD10922),
                              foregroundColor: Colors.white,
                            ),
                            child: Text('ค้นหาสลากกินแบ่งรัฐบาล'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Text(
                  "ใบสลาก ราคา 80 บาท",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD10922),
                  ),
                ),
              ),
              ...List.generate(10, (i) {
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
                            left: 200,
                            top: 65,
                            child: Text(
                              "วันที่ 1 ธันวาคม 2569",
                              style: TextStyle(
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
                              "9 9 9 9 9 9",
                              style: TextStyle(
                                fontSize: 30,
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });

          if (value == 1) {
          } else if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
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
}
