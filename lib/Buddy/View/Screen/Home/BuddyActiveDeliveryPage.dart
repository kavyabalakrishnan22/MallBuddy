import 'package:flutter/material.dart';

class BuddyActiveDeliveryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = List.generate(2, (index) => {
    "orderId": "#12345",
    "customerName": "Kavya Krishnan K K",
    "invoices": [
      "Zara Invoice 1 (ID#123)",
      "Zara Invoice 2 (ID#231)",
      "Max Invoice 1 (ID#215)",
    ],
    "rider": "Adhi",
    "riderId": "Adhi01",
    "deliveryTime": "10:00 am",
    "deliveryLocation": "First floor, H01",
    "status": "Pending",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Active delivery", style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
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
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Order ID & Status**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID ${order['orderId']}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Status : ${order['status']}",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            /// **Customer Name & Image**
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/profile/girl.png"),
                ),
                SizedBox(width: 8),
                Text(
                  order['customerName'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),

            /// **Invoices**
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order['invoices']
                  .map<Widget>((invoice) => Text(invoice))
                  .toList(),
            ),
            SizedBox(height: 10),

            /// **Rider Information**
            Text(
              "${order['rider']} (Rider ID : ${order['riderId']})",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            /// **Delivery Time & Location**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Time"),
                Text(
                  order['deliveryTime'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Location"),
                Text(
                  order['deliveryLocation'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
