import 'package:flutter/material.dart';

import '../../../Model/User_Management/shop_model.dart';
import 'Shop/Accepted_shop_page.dart';
import 'Shop/Admin_Rejected_shop.dart';
import 'Shop/Registered_shop.dart';

class AdminShop extends StatefulWidget {
  const AdminShop({super.key});

  @override
  State<AdminShop> createState() => _AdminShopState();
}

class _AdminShopState extends State<AdminShop>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header and Search Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Hello,", style: TextStyle(fontSize: 22)),
                        Text("Good Morning Team!",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                          "Unlock insights, track growth, and manage performance effortlessly.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(width: 300),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.black),
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
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/profile/girl.png'),
                              ),
                              SizedBox(width: 10),
                              Text("Admin",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // TabBar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.blue,
                indicatorWeight: 3,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "All Shop"),
                  Tab(text: "Registered Shop"),
                  Tab(text: "Accepted Shop"),
                  Tab(text: "Rejected Shop"),
                ],
              ),

              const SizedBox(height: 10),

              // TabBarView (Displays content based on selected tab)
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildShopTable("All Shops"),
                    RegisteredShop(), // Include the Registered Shop Page directly
                    AdminAcceptedShop(),
                    AdminRejectedShop(),
                    // _buildShopTable("Add Shop"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build shop tables dynamically
  Widget _buildShopTable(String title) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: DataTable(dataRowMaxHeight: 100,
          decoration: const BoxDecoration(color: Colors.white),
          columns: [
            _buildColumn('SL NO'),
            _buildColumn('Owner Details'),
            _buildColumn('Shop Name'),
            _buildColumn('Floor'),
            // _buildColumn('Phone Number'),
            // _buildColumn('Email'),
            _buildColumn('Edit'),
            _buildColumn('Edit'),
            _buildColumn('Delete'),
          ],
          rows: List.generate(
            shops.length,
            (index) {
              final shop = shops[index];
              return DataRow(
                cells: [
                  DataCell(Text((index + 1).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop.Owner_Name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis, // Handles long text
                        ),
                        Text(
                          shop.Phone_Number,
                          overflow: TextOverflow.ellipsis, // Handles long text
                        ),
                        Text(
                          shop.Email_ID,
                          overflow: TextOverflow.ellipsis, // Handles long text
                        ),Text("data")
                      ],
                    ),
                  ),

                  DataCell(Text(shop.Shop_Name)),
                  DataCell(Text(shop.Floor)),
                  // DataCell(Text(shop.Phone_Number)),
                  DataCell(Text(shop.Email_ID)),
                  DataCell(_buildButton("Edit", const Color(0xff0A71CB), () {}),),
                  DataCell(_buildButton("Delete", Colors.red, () => print("Button pressed!")),)
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

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        onPressed: onPressed,
        child: SizedBox(width: 70, child: Center(child: Text(text))),
      ),
    );
  }
}
