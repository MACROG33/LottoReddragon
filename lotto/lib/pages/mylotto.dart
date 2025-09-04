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
            // Left side - Black strip
            Container(width: 8, height: 80, color: Colors.black),
            SizedBox(width: 12),

            // Main ticket content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row with logo and numbers
                  Row(
                    children: [
                      // Logo circle
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'G',
                            style: TextStyle(
                              color: Colors.teal[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      // "THAI GOVERNMENT LOTTERY" text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'THAI GOVERNMENT LOTTERY',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

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
                      // Horse cart illustration placeholder
                      Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.brown[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.directions_car,
                            color: Colors.brown[600],
                            size: 20,
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      // QR Code placeholder
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                              ),
                          itemCount: 36,
                          itemBuilder: (context, index) {
                            return Container(
                              color: index % 3 == 0
                                  ? Colors.black
                                  : Colors.white,
                            );
                          },
                        ),
                      ),

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
                          Text(
                            '111111',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Bottom section
                  Row(
                    children: [
                      // 80 BAHT
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '80',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[600],
                            ),
                          ),
                          Text(
                            'BAHT',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.purple[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 20),

                      // Signature
                      Text(
                        'นาผล',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                      ),

                      Spacer(),

                      // Period and Set No
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Period: ',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Set No: ',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  '99',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Barcode
                  Container(
                    height: 20,
                    child: Row(
                      children: List.generate(
                        20,
                        (index) => Container(
                          width: index % 3 == 0 ? 3 : 1,
                          height: 20,
                          color: Colors.black,
                          margin: EdgeInsets.only(right: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
