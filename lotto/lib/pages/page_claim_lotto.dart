import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
                color: Color(0xFFD9D9D9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // รูป + overlay อยู่ใน Stack
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
                              onPressed: popUpClaimLotto,
                              style: FilledButton.styleFrom(
                                backgroundColor: Color(0xFFFFD700),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: Size(300, 48),
                                padding: EdgeInsets.symmetric(vertical: 12),
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

  void popUpClaimLotto() {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        content: const Text(
          'คุณแน่ใจไหมที่จะขึ้นเงิน',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.back();

                  Get.dialog(
                    const AlertDialog(
                      content: Text(
                        "ขึ้นเงินรางวัลสำเร็จ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    barrierDismissible: false,
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    Get.back();
                  });
                },
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
