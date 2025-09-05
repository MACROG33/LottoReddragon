import 'package:flutter/material.dart';

class LotteryTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Text(
          'สลากของฉัน',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            LotteryTicket(),
            SizedBox(height: 12),
            LotteryTicket(),
            SizedBox(height: 12),
            LotteryTicket(),
            SizedBox(height: 100), // Extra space at bottom
          ],
        ),
      ),
    );
  }
}

class LotteryTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Main ticket content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/lotto.png'),
                    fit: BoxFit.cover,
                    opacity: 1, // Make it subtle so text remains readable
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row with logo and numbers
                    Row(
                      children: [
                        // "THAI GOVERNMENT LOTTERY" text
                        Spacer(),

                        // Main lottery numbers
                        Text(
                          '999999',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Middle section with horse cart image and details
                    Row(
                      children: [
                        Spacer(),

                        // Date and details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'งวดที่ 1 ธันวาคม 2569',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black87,
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
          ],
        ),
      ),
    );
  }
}
