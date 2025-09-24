import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/pages/admin/Random.dart';
import 'package:lotto/pages/admin/make.dart';
import 'package:lotto/pages/page_login.dart';

class AdminPage extends StatefulWidget {
  final int idx;
  const AdminPage({super.key, required this.idx});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String url = '';
  String username = '';
  String email = '';
  String birthday = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th', null).then((_) {
      _loadProfile();
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
              Container(
                width: double.infinity,
                height: 280,
                decoration: const BoxDecoration(color: Color(0xFFD10922)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.create,
                        title: 'สร้าง Lotto',
                        onTap: () => Get.to(() => MakePage()),
                      ),
                      _buildMenuItem(
                        icon: Icons.shuffle,
                        title: 'สุ่ม Lotto',
                        onTap: () => Get.to(() => RandomPage()),
                      ),
                      _buildMenuItem(
                        icon: Icons.refresh,
                        title: 'รีเซ็ตระบบ',
                        onTap: resetData,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Get.offAll(() => LoginScreen()),
                        child: const Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// Profile Card
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
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
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.yellow[700]!, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          const AssetImage('assets/images/person.jpg')
                              as ImageProvider,
                      onBackgroundImageError: (_, __) {},
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'อีเมล: $email',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'วันเกิด: $birthday',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
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
      final response = await http.delete(Uri.parse("$url/admin/reset/app"));
      log(response.body);
    } catch (err) {
      log(err.toString());
    }
  }
   void resetData() {
    Get.dialog(
      AlertDialog(
         content: const Text(
          "รีเซ็ตระบบใหม่ทั้งหมด",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
                 backgroundColor: const Color(0xFFD10934),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
                  reSet(); // รีเซ็ตระบบ
              Get.back(); // ปิด dialog เก่า
              // แสดง dialog ใหม่แจ้งเสร็จสิ้น
              Get.dialog(
                const AlertDialog(
                  content: Text(
                    "รีเซ็ตระบบสำเร็จ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              );
              // ปิด dialog ใหม่อัตโนมัติหลัง 2 วินาที
              Future.delayed(const Duration(seconds: 1), () {
                if (Get.isDialogOpen ?? false) {
                  Get.back();
                }
              });
            },
            child: const Text(
              "ยืนยันการรีเซ็ตระบบ",
              textAlign: TextAlign.center,
            ),
          ),
            TextButton(onPressed: () => Get.back(), child: const Text("ยกเลิก")),
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
            // ignore: deprecated_member_use
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
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, color: Colors.grey[600]),
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

  Future<void> _loadProfile() async {
    try {
      final config = await Configuration.getConfig();
      url = config['apiEndpoint'];

      final res = await http.get(Uri.parse('$url/user/show/${widget.idx}'));
      log(widget.idx.toString());
      log(url);
      log(res.body);

      if (res.statusCode == 201) {
        var json = jsonDecode(res.body);

        if (json is List && json.isNotEmpty) {
          var data = json[0];

          setState(() {
            email = data['email'] ?? '';
            username = '${data['Firstname'] ?? ''} ${data['LastName'] ?? ''}';

            if (data['birthday'] != null &&
                data['birthday'].toString().isNotEmpty) {
              DateTime dt = DateTime.parse(data['birthday']);
              int buddhistYear = dt.year + 543;
              String monthThai = DateFormat.MMMM('th').format(dt);
              birthday = 'วันที่ ${dt.day} $monthThai พ.ศ. $buddhistYear';
            } else {
              birthday = '';
            }
          });
        } else {
          log('No user data found');
          setState(() {
            email = '';
            birthday = '';
            username = '';
          });
        }
      } else {
        log('Error fetching admin profile: ${res.statusCode}');
        setState(() {
          email = '';
          birthday = '';
          username = '';
        });
      }
    } catch (e) {
      log('Exception fetching admin profile: $e');
    }
  }
}
