import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lotto/model/request/Users_login_Post_Req.dart';
import 'package:lotto/model/response/Users_login_Post_Res.dart';
import 'package:lotto/pages/page_register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
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
                    TextField(
                      controller: emailController,

                      decoration: const InputDecoration(
                        labelText: "อีเมล",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: "รหัสผ่าน",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("เข้าสู่ระบบ")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageRegister()),
                );
              },
              child: const Text(
                "สมัครสมาชิก",
                style: TextStyle(
                  color: Colors.white, // ให้เข้ากับธีม
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // http://10.160.95.151:3000/auth/login
  void login() {
    String email = emailController.text;
    String password = passwordController.text;
    UsersLoginPostRequest req = UsersLoginPostRequest(
      email: email,
      password: password,
    );
    http
        .post(
          Uri.parse("http://10.160.95.151:3000/auth/login"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: usersLoginPostRequestToJson(req),
        )
        .then((value) {
          UsersLoginPostResponse res = usersLoginPostResponseFromJson(
            value.body,
          );
          log(res.user.lastName + " " + res.user.firstname);
        })
        .catchError((error) {
          log('Error $error');
        });
  }
}
