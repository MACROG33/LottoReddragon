import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;
import 'package:lotto/config/config.dart';

import 'package:lotto/pages/admin/Random.dart';
import 'package:lotto/pages/admin/make.dart';
import 'package:lotto/pages/page_login.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String url = '';
  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            children: [
              // Top Profile Section with Red Background
              Container(
                width: double.infinity,
                height: 280,
                decoration: const BoxDecoration(color: Color(0xFFD10922)),
              ),
              // Menu Items Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),

                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.create,
                        title: 'สร้าง Lotto',
                        onTap: () {
                          Get.to(() => MakePage());
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.shuffle,
                        title: 'สุ่ม Lotto',
                        onTap: () {
                          Get.to(() => RandomPage());
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.refresh,
                        title: 'รีเซ็ตระบบ',
                        onTap: resetData,
                      ),
                      const Spacer(),
                      // Logout Button
                      TextButton(
                        onPressed: () async {
                          Get.offAll(
                            () => LoginScreen(),
                          ); //ทำการล้างทุกอย่างเพื่อออกระบบ
                        },
                        child: const Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Overlapping Grey Rectangle with Profile Content
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Avatar with Border
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.yellow[700]!, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('assets/images/person.jpg'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Name
                  const Text(
                    'Admin Admin',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Subtitle
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ยอดเงินคงเหลือ : ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextSpan(
                          text: '200 บาท',
                          style: TextStyle(color: Colors.yellow, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'อีเมล:Karn.klangdee@gmail.com',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Date
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'วันเกิด:01/01/1990',
                      style: TextStyle(color: Colors.white, fontSize: 14),
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

  Future<void> reSet() async {
    try {
      final response = await http.delete(Uri.parse("$url/lotto/draws/delete"));
      log(response.body);
    } catch (err) {
      log(err.toString());
    }
  }

  void resetData() {
    Get.dialog(
      AlertDialog(
        content: Text(
          "รีเซ็ตระบบใหม่ทั้งหมด",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              reSet();
              Get.back();
            },
            child: Text("ยืนยันการรีเซ็ตระบบ", textAlign: TextAlign.center),
          ),
          TextButton(onPressed: () => Get.back(), child: Text("ยกเลิก")),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    IconData? icon,
    String? imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[600],
                      size: 24,
                    );
                  },
                ),
              )
            : Icon(icon, color: Colors.grey[600]),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
