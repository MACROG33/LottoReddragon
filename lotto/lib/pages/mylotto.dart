import 'package:flutter/material.dart';

class PageLottoTicketScreen extends StatefulWidget {
  const PageLottoTicketScreen({super.key});

  @override
  State<PageLottoTicketScreen> createState() => _PageLottoTicketScreenState();
}

class _PageLottoTicketScreenState extends State<PageLottoTicketScreen> {
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
      body: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 0),
          itemCount: 5,
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
