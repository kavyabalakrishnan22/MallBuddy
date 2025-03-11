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
  Map<int, bool> selectedEdit = {}; // Track Edit button state
  Map<int, bool> selectedDelete = {};

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
                  Tab(text: "All Shop"),SizedBox(width: 100,),
                  Tab(text: "Registered Shop"),SizedBox(width: 100,),
                  Tab(text: "Accepted Shop"),SizedBox(width: 100,),
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
                  DataCell(_buildToggleButton("Edit", index, true)),
                  DataCell(_buildToggleButton("Delete", index, false)),
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
        child: SizedBox(width: 90, height: 50, child: Center(child: Text(text))),
      ),
    );
  }


  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this customer?"),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                setState(() { shops.removeAt(index); });
                Navigator.of(context).pop();
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
