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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFD10934),
                Color(0xFFD10934), 
                Colors.white, 
              ],
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
                        Center(child: FilledButton(onPressed: () {}, child: Text('ค้นหา'))),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  "ใบสลาก ราคา 80 บาท",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD10922),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ...List.generate(
                20,
                (i) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text("test"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
