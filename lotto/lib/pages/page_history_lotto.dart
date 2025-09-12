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
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFFD10922),
                    ),
                    onPressed: () {},
                    child: const Text('ทั้งหมด'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFFD10922),
                    ),
                    onPressed: () {},
                    child: const Text('ประวัติการถูกรางวัล'),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFFD10922),
                    ),
                    onPressed: () {},
                    child: const Text('ประวัติไม่ถูกรางวัล'),
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
                // สมมติว่าเรามีตัวเลขใหม่เก็บใน list ของ int
                int newNumber = i + 1; // หรือเอามาจาก list ของตัวเลขจริง

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Card(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Image.asset("assets/images/lotto.png"),

                        // กล่องสีขาวทับเลขเดิม
                        Positioned(
                          left: 50, // ปรับตำแหน่ง x
                          top: 30, // ปรับตำแหน่ง y
                          child: Container(
                            width: 100, // กว้างพอที่จะทับเลขเดิม
                            height: 40, // สูงพอ
                            color: Colors.white,
                          ),
                        ),

                        // ตัวเลขใหม่
                        Positioned(
                          left: 50,
                          top: 30,
                          child: Text(
                            "$newNumber",
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
