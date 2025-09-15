import 'package:flutter/material.dart';
import 'package:lotto/pages/admin/Random.dart';
import 'package:lotto/pages/admin/Test.dart';
import 'package:lotto/pages/admin/make.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                decoration: const BoxDecoration(color: Colors.red),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        imagePath: 'assets/images/create.png',
                        title: 'สร้าง lotto',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MakePage(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        imagePath: 'assets/images/random.png',
                        title: 'สุ่ม lotto',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RandomPage(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        imagePath: 'assets/images/reset.png',
                        title: 'รีเช็ตระบบ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DropdownButtonApp(),
                            ),
                          );
                        },
                      ),

                      const Spacer(),

                      // Logout Button
                      TextButton(
                        onPressed: () {},
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

          Positioned(
            top: 20,
            left: 20,
            right: 20,
            bottom: 500,
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
                    'Admin',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'อีเมล: Admin@Admin.com',
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
