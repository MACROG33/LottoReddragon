import 'package:flutter/material.dart';
import 'package:lotto/pages/page_login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                decoration: const BoxDecoration(color: Colors.red),
              ),

              // Menu Items Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        imagePath: 'assets/images/slip.jpg',
                        title: 'ฉลากของฉัน',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        imagePath: 'assets/images/celebate.jpg',
                        title: 'ประวัติการถูกรางวัล',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        imagePath: 'assets/images/money.jpg',
                        title: 'ขึ้นเงินรางวัล',
                        onTap: () {},
                      ),

                      const Spacer(),

                      // Logout Button
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
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

              // Bottom Navigation
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomNavItem(Icons.home, 'หน้าหลัก'),
                    _buildBottomNavItem(Icons.shopping_cart, 'ซื้อฉลาก'),
                    _buildBottomNavItem(Icons.person, 'ฉัน'),
                  ],
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
                    height: 100,
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
                  SizedBox(height: 15),
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

  Widget _buildMenuItem({
    IconData? icon,
    String? imagePath, // Add this parameter for image path
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
                borderRadius: BorderRadius.circular(
                  4,
                ), // Optional: rounded corners
                child: Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback icon if image fails to load
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

  Widget _buildBottomNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey[600], size: 28),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}
