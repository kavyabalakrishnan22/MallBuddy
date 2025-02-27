import 'package:flutter/material.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';


class ShopOrderhistory extends StatefulWidget {
  const ShopOrderhistory({super.key});

  @override
  State<ShopOrderhistory> createState() => _ShopOrderhistoryState();
}

class _ShopOrderhistoryState extends State<ShopOrderhistory> {
  // Active Tab
  String activeTab = "All orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "My orders",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Order Status Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton("All orders"),
                _buildTabButton("In Progress"),
                _buildTabButton("Delivered"),
                _buildTabButton("Canceled"),
              ],
            ),
            const SizedBox(height: 20),
            // Order List
            Expanded(
              child: ListView(
                children: [
                  _buildOrderCard(
                    orderId: "#kavya01234",
                    riderId: "Adhi01",
                    items: 6,
                    amount: 20000,
                    status: "Buddy Reached",
                    statusColor: Colors.green,
                    buttonText: "Order QR",
                    buttonColor: defaultBlue,
                  ),
                  _buildOrderCard(
                    orderId: "#kavya01234",
                    riderId: "Adhi01",
                    items: 6,
                    amount: 20000,
                    status: "Pending",
                    statusColor: Colors.orange,
                    buttonText: "Order QR",
                    buttonColor:defaultBlue,
                  ),
                  _buildOrderCard(
                    orderId: "#kavya01234",
                    riderId: "Adhi01",
                    items: 6,
                    amount: 20000,
                    status: "Delivered",
                    statusColor: Colors.green,
                    buttonText: "Order QR",
                    buttonColor: defaultBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Order Status Tabs
  Widget _buildTabButton(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: activeTab == text ? defaultBlue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: activeTab == text ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Order Card Widget
  Widget _buildOrderCard({
    required String orderId,
    required String riderId,
    required int items,
    required int amount,
    required String status,
    required Color statusColor,
    required String buttonText,
    required Color buttonColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "ORDER $orderId",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Text("Status ", style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text(
                status,
                style: TextStyle(fontSize: 14, color: statusColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text("Rider ID : $riderId", style: const TextStyle(fontSize: 14, color: Colors.black)),
          Text("Total items : $items", style: const TextStyle(fontSize: 14, color: Colors.black)),
          Text("Total amount : $amount", style: const TextStyle(fontSize: 14, color: Colors.black)),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: buttonColor == Colors.black
                      ? const BorderSide(color: Colors.black)
                      : BorderSide.none,
                ),
              ),
              onPressed: () {},
              child: Text(buttonText, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
