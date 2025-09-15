import 'package:flutter/material.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  final List<String> items = [
    'รางวัลที่1',
    'รางวัลที่2',
    'รางวัลที่3',
    'รางวัลเลขท้าย 3 ตัว',
    'รางวัลเลขท้าย 2 ตัว',
  ];

  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RandomPage")),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  mainAxisSize: MainAxisSize.min, // ให้ Card ขนาดพอดีกับเนื้อหา
                  children: [
                    const Text(
                      "สุ่มฉลากกินแบ่งรัฐบาล",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldRow(),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Color(0xFFD10934),
                                ),
                                onPressed: () {
                                  // TODO: เขียนฟังก์ชันสุ่มเลขทั้งหมด
                                },
                                child: const Text(
                                  "สุ่มเลขทั้งหมด",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Color(0xFFD10934),
                                ),
                                onPressed: () {
                                  // TODO: เขียนฟังก์ชันสุ่มเลขที่ถูกซื้อแล้ว
                                },
                                child: const Text(
                                  "สุ่มเลขที่ถูกชื้อไปแล้ว",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        // เพิ่ม Expanded ให้ Dropdown ขยายเต็ม Row
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              isExpanded: true, // ให้ Dropdown กว้างเต็มพื้นที่
                              hint: Text(
                                'เลือกผลรางวัล',
                              ), // ข้อความแสดงก่อนเลือก
                              value: selectedItem,
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedItem = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
    );
  }

  Widget TextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          width: 40,

          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            enabled: false,
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
}
