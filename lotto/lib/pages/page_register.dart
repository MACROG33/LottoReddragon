import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/model/request/Users_Register_Post_Req.dart';
import 'package:lotto/model/response/Users_Register_Post_Res.dart';
import 'package:lotto/pages/page_login.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  DateTime? _selectedDate;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController walletController = TextEditingController();

  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD10922),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'สมัครสมาชิกผู้ใช้งาน',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('ชื่อจริง', style: TextStyle(color: Colors.white)),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('นามสกุล', style: TextStyle(color: Colors.white)),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('วันเกิด', style: TextStyle(color: Colors.white)),
                  TextField(
                    controller: _dateOfBirthController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('อีเมล์', style: TextStyle(color: Colors.white)),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('รหัสผ่าน', style: TextStyle(color: Colors.white)),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('ยืนยันรหัสผ่าน', style: TextStyle(color: Colors.white)),
                  TextField(
                    controller: checkPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'จำนวนเงินในระบบ (บาท)',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: walletController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFFFFD700),
                        textStyle: TextStyle(fontSize: 16),
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: _showCustomDialog,
                      child: Text('สมัครสมาชิก'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // จัดตรงกลางแถว
                    children: [
                      Text(
                        'มีบัญชีอยู่แล้ว?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(color: Color(0xFFFFD700)),
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
    );
  }

  void register() {
    try {
      double wallet = double.parse(walletController.text);
      String input = _dateOfBirthController.text.trim();
      DateFormat format = DateFormat('d/M/yyyy'); // วัน/เดือน/ปี
      DateTime birthday = format.parseStrict(input);
      print("Birthday = $birthday");
      if (passwordController.text == checkPasswordController.text) {
        UsersRegisterPostResRequest req = UsersRegisterPostResRequest(
          firstname: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          wallet: wallet,
          birthday: birthday,
        );

        http
            .post(
              Uri.parse("$url/auth/register"),
              headers: {"Content-Type": "application/json; charset=utf-8"},
              body: usersRegisterPostResRequestToJson(req),
            )
            .then((value) {
              UsersRegisterPostResResponse res =
                  usersRegisterPostResResponseFromJson(value.body);
              log(res.message);
            })
            .catchError((error) {
              log('Error $error');
            });
      } else {
        log("รหัสผ่านไม่ตรงกัน");
      }
    } catch (e) {
      log("Error");
    }
  }

  //Dialog register
  void _showCustomDialog() {
    // ตรวจสอบว่าทุก field ต้องไม่ว่าง
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        checkPasswordController.text.isEmpty ||
        emailController.text.isEmpty ||
        walletController.text.isEmpty) {
      Get.dialog(
        const AlertDialog(
          content: SizedBox(
            height: 150,
            child: Center(
              child: Text(
                "กรุณากรอกข้อมูลให้ครบทุกช่อง",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
      return;
    }

    // ✅ ตรวจสอบรหัสผ่านว่าตรงกันหรือไม่
    if (passwordController.text != checkPasswordController.text) {
      Get.dialog(
        AlertDialog(
          content: const Text(
            "รหัสผ่านไม่ตรงกัน",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: const Text("ปิด"),
              ),
            ),
          ],
        ),
      );
      return; // ออกจากฟังก์ชันทันที
    }

    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        content: const Text(
          'ยืนยันการสมัครสมาชิก',
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
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.back();
                  register();

                  Get.dialog(
                    const AlertDialog(
                      content: Text(
                        "สมัครสมาชิกสำเร็จ",
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
                    Get.offAll(() => const LoginScreen());
                  });
                },
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
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

  //Progress Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFD10922),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
