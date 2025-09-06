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
          // ปุ่มคงที่ ไม่เลื่อน
          Padding(
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

          // การ์ดเลื่อน
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Loop Card 10 อัน
                  ...List.generate(
                    10,
                    (index) => Card(
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'งวดประจำวันที่ 16 มีนาคม 2567 (${index + 1})',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('รางวัลที่ 1'),
                                    SizedBox(height: 4),
                                    Text(
                                      '123456',
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('เลขท้าย 2 ตัว'),
                                    SizedBox(height: 4),
                                    Text(
                                      '78',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
