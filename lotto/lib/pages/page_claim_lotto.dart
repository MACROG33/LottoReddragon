import 'package:flutter/material.dart';

class PageClaimLotto extends StatefulWidget {
  const PageClaimLotto({super.key});

  @override
  State<PageClaimLotto> createState() => _PageClaimLottoState();
}

class _PageClaimLottoState extends State<PageClaimLotto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: Text('ขึ้นเงินรางวัล', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFFD10922),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 0),
        itemCount: 2,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // รูป + overlay อยู่ใน Stack
                    Stack(
                      children: [
                        Image.asset("assets/images/lotto.png"),

                        // กล่องทับเลขเดิม
                        Positioned(
                          left: 195,
                          top: 15,
                          child: Container(
                            width: 155,
                            height: 40,
                            color: Colors.grey,
                          ),
                        ),
                        // กล่องทับเลขวันที่
                        Positioned(
                          left: 195,
                          top: 65,
                          child: Container(
                            width: 155,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ),
                        //เอาวันที่มาจาก DB
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
                        // ตัวเลขที่เอามาจาก Db
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

                    // ส่วนข้อความด้านล่าง
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "ถูกรางวัลที่ 1",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF28A745),
                            ),
                          ),
                          Text(
                            "จำนวนเงิน 6,000,000 บาท",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: Color(0xFFFFD700), // สีทอง
                                foregroundColor: Colors.black, // สีตัวอักษร
                                shape: RoundedRectangleBorder(
                                  // ขอบโค้ง
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: Size(
                                  300,
                                  48,
                                ), // ความกว้างเต็ม + สูง 48px
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                ), // padding เพิ่มความสูง
                              ),
                              child: Text("ขึ้นเงินรางวัล"),
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
    );
  }
}
