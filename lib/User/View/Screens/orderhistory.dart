import 'package:flutter/material.dart';




class Orderhistory extends StatelessWidget {
  const Orderhistory({super.key, required String orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "Order History",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
           CircleAvatar(
            backgroundImage: AssetImage(
                'assets/profile/girl.png'), // Replace with actual image
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code

            const SizedBox(height: 20),
            // Order Details
            const Text(
              "ORDER #kavya01234",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDetailText("Rider ID", "Adhi01"),
            _buildDetailText("Total items", "6"),
            _buildDetailText("Total amount", "20000"),
          ],
        ),
      ),
    );
  }

  // Widget to display order details
  Widget _buildDetailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "$title : $value",
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
