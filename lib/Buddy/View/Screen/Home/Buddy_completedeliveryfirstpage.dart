import 'package:flutter/material.dart';

import '../../../../Widgets/Constants/colors.dart';

class BuddyCompleteDeliveryFirstScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = List.generate(2, (index) => {
    "orderId": "#12345",
    "riderId": "#12345",
    "customerName": "Kavya Krishnan K K",
    "status": "Delivered",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Complete Delivery",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return DeliveryCard(order: orders[index]);
          },
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final Map<String, dynamic> order;
  const DeliveryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// **Profile Image (Left Side)**
            const CircleAvatar(
              radius: 38,
              backgroundImage: AssetImage("assets/profile/girl.png"),
            ),
            const SizedBox(width: 10),

            /// **Order Details (Right Side)**
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Order ID & "See Details" Button**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ID ${order['orderId']}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "see details >",
                          style: TextStyle(color: defaultBlue, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 5),

                  /// **Rider ID**
                  Text(
                    "Rider ID ${order['riderId']}",
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 5),

                  /// **Customer Name**
                  Text(
                    order['customerName'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ), SizedBox(height: 20),

                  /// **Delivery Status (Right Aligned)**
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,border: Border.all(color: Colors.green,width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Status : Delivered",
                        style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
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
