import 'package:flutter/material.dart';
import '../../../Model/User_Management/Customer_model.dart';

class AdminCustomer extends StatefulWidget {
  const AdminCustomer({super.key});

  @override
  State<AdminCustomer> createState() => _AdminCustomerState();
}

class _AdminCustomerState extends State<AdminCustomer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {}; // Track Edit button state
  Map<int, bool> selectedDelete = {}; // Track Delete button state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildShopTable("All Customer"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Hello,", style: TextStyle(fontSize: 22)),
              Text("Good Morning Team!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile/girl.png'),
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
    );
  }

  Widget _buildTabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.blue,
        isScrollable: true,
        tabs: const [
          Tab(text: "All Customers"),
        ],
      ),
    );
  }

  Widget _buildShopTable(String title) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: DataTable(
          dataRowMaxHeight: 80,
          decoration: const BoxDecoration(color: Colors.white),
          columns: [
            _buildColumn('SL NO'),
            _buildColumn('Customer Details'),
            _buildColumn('Invoice ID'),
            _buildColumn('Edit'),
            _buildColumn('Delete'),
          ],
          rows: List.generate(
            customers.length,
                (index) {
              final customer = customers[index];
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
                          customer.Customer_Name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(customer.Phone_Number, overflow: TextOverflow.ellipsis),
                        Text(customer.Email, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  DataCell(Text(customer.Invoice_ID)),
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

  // Widget _buildToggleButton(String text, int index, bool isEdit) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ElevatedButton(
  //       onPressed: () {
  //         if (isEdit) {
  //           setState(() {
  //             selectedEdit[index] = !(selectedEdit[index] ?? false);
  //           });
  //         } else {
  //           _showDeleteDialog(index);
  //         }
  //       },
  //       child: SizedBox(width: 90, height: 50, child: Center(child: Text(text))),
  //     ),
  //   );
  // }
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
                setState(() { customers.removeAt(index); });
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