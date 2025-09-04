import 'package:flutter/material.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD10922),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'สมัครสมาชิกผู้ใช้งาน',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ชื่อจริง', style: TextStyle(color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text('นามสกุล', style: TextStyle(color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text('วันเกิด', style: TextStyle(color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text('อีเมล์', style: TextStyle(color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text('รหัสผ่าน', style: TextStyle(color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text('ยืนยันรหัสผ่าน', style: TextStyle(color: Colors.white)),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text(
                    'จำนวนเงินในระบบ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Center(
                    child: FilledButton(
                      onPressed: () {},
                      child: Text('สมัครสมาชิก'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // จัดตรงกลางแถว
                    children: [
                      Text(
                        'มีบัญชีอยู่แล้ว?',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        ' เข้าสู่ระบบ',
                        style: TextStyle(color: Color(0xFFFFD700)), // สีทอง
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
