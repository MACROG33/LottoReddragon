import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lotto/config/config.dart';
import 'package:lotto/pages/home.dart';
import 'package:lotto/pages/page_claim_lotto.dart';
import 'package:lotto/pages/page_history_lotto.dart';
import 'package:lotto/pages/page_login.dart';
import 'package:lotto/pages/mylotto.dart';
import 'package:lotto/pages/page_search_lotto.dart';

class ProfilePage extends StatefulWidget {
  final int idx;
  const ProfilePage({super.key, required this.idx});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double? balance;
  String email = '';
  String birthday = '';
  String username = '';
  String url = '';
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th', null).then((_) {
      _loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration: const BoxDecoration(color: Color(0xFFD10922)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          imagePath: 'assets/images/slip.jpg',
                          title: 'ฉลากของฉัน',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PageLottoTicketScreen(idx: widget.idx),
                              ),
                            );
                          },
                        ),
                        _buildMenuItem(
                          imagePath: 'assets/images/celebate.jpg',
                          title: 'ประวัติการถูกรางวัล',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageHistoryLotto(idx: widget.idx,),
                              ),
                            );
                          },
                        ),
                        _buildMenuItem(
                          imagePath: 'assets/images/money.jpg',
                          title: 'ขึ้นเงินรางวัล',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PageClaimLotto(idx: widget.idx),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 250),

                        TextButton(
                          onPressed: () {
                            Get.offAll(() => LoginScreen());
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
                      ],
                    ),
                  ),
                ],
              ),
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
                          border: Border.all(
                            color: Colors.yellow[700]!,
                            width: 3,
                          ),
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
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'ยอดเงินคงเหลือ : ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: balance != null
                                  ? '${balance!.toStringAsFixed(2)} บาท'
                                  : 'กำลังโหลด...',
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'อีเมล: $email',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'วันเกิด: $birthday',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });

          if (value == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(idx: widget.idx),
              ),
            );
          } else if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageSearchLotto(idx: widget.idx),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'ซื้อสลาก',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ฉัน'),
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
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[600],
                    size: 24,
                  ),
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
        var decoded = jsonDecode(res.body);

        if (decoded is List && decoded.isNotEmpty) {
          var data = decoded[0]; // ใช้ element แรกอย่างปลอดภัย

          setState(() {
            balance = data['wallet'] != null
                ? double.tryParse(data['wallet'].toString()) ?? 0
                : 0;
            email = data['email'] ?? '';

            // แปลงวันเกิดเป็น "วันที่ 20 กันยายน พ.ศ. 2568"
            if (data['birthday'] != null &&
                data['birthday'].toString().isNotEmpty) {
              DateTime dt = DateTime.parse(data['birthday']);
              int buddhistYear = dt.year + 543; // แปลงเป็น พ.ศ.
              String monthThai = DateFormat.MMMM(
                'th',
              ).format(dt); // เดือนเป็นภาษาไทย
              birthday = 'วันที่ ${dt.day} $monthThai พ.ศ. $buddhistYear';
            } else {
              birthday = '';
            }

            username = '${data['Firstname'] ?? ''} ${data['LastName'] ?? ''}';
          });
        } else {
          log('No user data found.');
          // กรณี list ว่าง ให้รีเซ็ตค่า UI
          setState(() {
            balance = 0;
            email = '';
            birthday = '';
            username = '';
          });
        }
      } else {
        log('Error fetching profile: ${res.statusCode}');
      }
    } catch (e) {
      log('Exception fetching profile: $e');
    }
  }
}
