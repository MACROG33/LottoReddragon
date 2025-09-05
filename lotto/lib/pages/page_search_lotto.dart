import 'package:flutter/material.dart';

class PageSearchLotto extends StatefulWidget {
  const PageSearchLotto({super.key});

  @override
  State<PageSearchLotto> createState() => _PageSearchLottoState();
}

class _PageSearchLottoState extends State<PageSearchLotto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD10922),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'หมายเลขสลาก',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
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
    
            // หัวข้อตรึง
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  "ใบสลาก ราคา 80 บาท",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD10922),
                  ),
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
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text('123456'),
                        subtitle: Text('งวดประจำวันที่ 16 มีนาคม 2567'),
                        trailing: Text(
                          '80 บาท',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD10922),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'ซื้อสลาก'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ฉัน'),
        ],
      ),
    );
  }
}

