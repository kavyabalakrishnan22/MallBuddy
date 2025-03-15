import 'package:flutter/material.dart';
import '../../../Model/User_Management/shop_model.dart';
import '../../../Model/ordermonitoring_model/Rider_performance_model.dart';
import 'AdminAllorders.dart';


class AdminRidrPerformnace extends StatefulWidget {
  const AdminRidrPerformnace({super.key});

  @override
  State<AdminRidrPerformnace> createState() => _AdminRidrPerformnaceState();
}

class _AdminRidrPerformnaceState extends State<AdminRidrPerformnace>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // FIXED: length = 4
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello,", style: TextStyle(fontSize: 22)),
                    Text("Good Morning Team!",
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                      "Unlock insights, track growth, and manage performance effortlessly.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage:
                            AssetImage('assets/profile/girl.png'),
                          ),
                          SizedBox(width: 10),
                          Text("Admin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TabBar
            TabBar(
              controller: _tabController, // FIXED: Using only one TabController
              isScrollable: true,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Rider Performace"),
                // Tab(text: "Complete Order"),
                // Tab(text: "Rider Performance"),
                // // Tab(text: "Customer Feedback"),
              ],
            ),

            const SizedBox(height: 10),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(), // FIXED: Ensures smooth scrolling
                children: [
                  // AdminAllOrders(),
                  // AdminCompleteOrders(),
                  _buildShopTable("Rider Performace")
                  // AdminRejectedShop(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build shop tables dynamically
  Widget _buildShopTable(String title) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: DataTable(
          dataRowMaxHeight: 100,
          decoration: const BoxDecoration(color: Colors.white),
          columns: [
            _buildColumn('SL NO'),
            _buildColumn('ID'),
            _buildColumn('Rider Details'),
            _buildColumn('Order ID'),
            _buildColumn('Invoice ID'),
            _buildColumn('Total Delivery'),
            _buildColumn('Total Amount'),
            _buildColumn('Rating'),
            _buildColumn('Delete'),

          ],
          rows: List.generate(
            riders.length,
                (index) {
              final rider = riders[index];
              return DataRow(
                cells: [
                  DataCell(Text((index + 1).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(rider.Id)),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rider.Rider_ID,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),Text(rider.Rider_Name,)
                      ],
                    ),
                  ),
                  DataCell(Text(rider.Order_ID)),
                  DataCell(Text(rider.Invoice_ID)),
                  DataCell(Text(rider.Total_Delivery)),
                  DataCell(Text(rider.Total_Amount)),
                  DataCell(Text(rider.Rating)),
                  DataCell(Row(
                  children: [
                  _buildOutlinedButton("Delete", Colors.red, Colors.red, () {
                  print("Delete button pressed!");
                  }), ],
                  )),             ],
              );
            },
          ),
        ),
      ),
    );
  }

  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    );
  }

  Widget _buildToggleButton(String text, int index, bool isEdit) {
    bool isSelected = isEdit
        ? (selectedEdit[index] ?? false)
        : (selectedDelete[index] ?? false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                isSelected ? Colors.blue : Colors.white),
            foregroundColor: MaterialStateProperty.all(
                isSelected ? Colors.white : Colors.black),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isSelected ? Colors.blue : Colors.black),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (isEdit) {
                selectedEdit[index] = !(selectedEdit[index] ?? false);
              } else {
                selectedDelete[index] = !(selectedDelete[index] ?? false);
                _showDeleteDialog(index);
              }
            });
          },
          child: SizedBox(width: 90, height: 50, child: Center(child: Text(text)))),
    );
  }
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this shop?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  shops.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
  Widget _buildOutlinedButton(String text, Color textColor, Color borderColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor, // Text color
          side: BorderSide(color: borderColor), // Border color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
