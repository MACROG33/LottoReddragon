import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';

import 'package:lotto/model/request/Users_login_Post_Req.dart';
import 'package:lotto/pages/admin/admin.dart';
import 'package:lotto/pages/home.dart';
import 'package:lotto/pages/page_register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/logo_lotto.png', height: 350),
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 2),
                            child: Text(
                              "อีเมล์",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ), // ปรับ padding ภายในช่อง
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                            child: Text(
                              "รหัสผ่าน",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ), // ปรับ padding ภายในช่อง
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: login,
                icon: Icon(Icons.login),
                label: Text("เข้าสู่ระบบ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ไม่มีบัญชี?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageRegister(),
                        ),
                      );
                    },

                    child: Text(
                      "สมัครสมาชิก",
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontWeight: FontWeight.bold,
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
  }

  // http://10.160.95.151:3000/auth/login
  void login() async {
    String email = emailController.text;
    String password = passwordController.text;
    log("$email $password");
    if (email.isEmpty || password.isEmpty) {
      showError("โปรดใส่อีเมลและรหัสผ่าน");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("$url/auth/login"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: usersLoginPostRequestToJson(
          UsersLoginPostRequest(email: email, password: password),
        ),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // login สำเร็จ
        if (data['user']['role'] == "admin") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(idx: data['user']['user_id']),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(idx: data['user']['user_id']),
            ),
          );
        }
      } else {
        showError("รหัสผ่านหรืออีเมลไม่ถูกต้อง");
      }
    } catch (e) {
      showError("เกิดข้อผิดพลาด กรุณาลองใหม่");
      log("Login error: $e");
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          message,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("ปิด"),
            ),
          ),
        ],
      ),
    );
  }
}
