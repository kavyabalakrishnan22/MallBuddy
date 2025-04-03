import 'package:flutter/material.dart';
import '../../../Model/ordermonitoring_model/Rider_performance_model.dart';


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
                ],
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

}
