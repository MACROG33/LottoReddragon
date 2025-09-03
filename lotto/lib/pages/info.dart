import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            padding: EdgeInsets.only(top: 30, bottom: 20, left: 50, right: 50),
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 80, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  "กานต์ กลองดี",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "ยอดเงินคงเหลือ : 200 บาท",
                  style: TextStyle(fontSize: 14, color: Colors.amber),
                ),
                SizedBox(height: 5),
                Text(
                  "อีเมล์: Karn.klangdee@gmail.com",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Text(
                  "วันเกิด: 01/01/1990",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),

          // เมนู
          Expanded(
            child: ListView(
              children: [
                buildMenuItem(Icons.note, "สลากของฉัน"),
                buildMenuItem(Icons.history, "ประวัติการถูกรางวัล"),
                buildMenuItem(Icons.card_giftcard, "ขึ้นเงินรางวัล"),
              ],
            ),
          ),

          // ปุ่มออกจากระบบ
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "ออกจากระบบ",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bottom Navigation
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "หน้าหลัก",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "ซื้อลอตเตอรี่",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: "อื่น",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.black),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
