import 'package:flutter/material.dart';

class PageHistoryLotto extends StatefulWidget {
  const PageHistoryLotto({super.key});

  @override
  State<PageHistoryLotto> createState() => _PageHistoryLottoState();
}

class _PageHistoryLottoState extends State<PageHistoryLotto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD10922),
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
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFFD10922),
                      ),
                      onPressed: () {},
                      child: const Text('ทั้งหมด'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFFD10922),
                      ),
                      onPressed: () {},
                      child: const Text('ประวัติการถูกรางวัล'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFFD10922),
                      ),
                      onPressed: () {},
                      child: const Text('ประวัติไม่ถูกรางวัล'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // การ์ดเลื่อน
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 0),
              itemCount: 100,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Card(
                      color: Color(0xFFD9D9D9),
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
                              Positioned(
                                left: 40,
                                top: 115,
                                child: Text(
                                  "80\nบาท",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // พื้นที่ด้านล่างของ Card
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "ถูกรางวัลที่ 1",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  "จำนวนเงิน 6,000,000 บาท",
                                  style: TextStyle(
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
            ),
          ),
        ],
      ),
    );
  }
}
