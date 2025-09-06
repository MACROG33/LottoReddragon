import 'package:flutter/material.dart';

class PageClaimLotto extends StatefulWidget {
  const PageClaimLotto({super.key});

  @override
  State<PageClaimLotto> createState() => _PageClaimLottoState();
}

class _PageClaimLottoState extends State<PageClaimLotto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: Text('ขึ้นเงินรางวัล', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFFD10922),
      ),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Page Claim Lotto', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFFFFD700),
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black, // สีเส้นขอบ
                      width: 2.0, // ความหนาของเส้นขอบ
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('ขึ้นเงินรางวัล'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
