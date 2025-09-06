import 'package:flutter/material.dart';

class PageAdminLotto extends StatefulWidget {
  const PageAdminLotto({super.key});

  @override
  State<PageAdminLotto> createState() => _PageAdminLottoState();
}

class _PageAdminLottoState extends State<PageAdminLotto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.red)),
              Expanded(flex: 2, child: Container(color: Colors.white)),
            ],
          ),
          Align(
            alignment: Alignment.center, // ครึ่งทางระหว่างสองสี
            child: Card(
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        'assets/images/logo_lotto.png',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Admin Lotto',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'admin@example.com',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      'Birthday: 01/01/1990',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
