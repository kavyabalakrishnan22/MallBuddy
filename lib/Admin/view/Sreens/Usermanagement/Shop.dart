import 'package:flutter/material.dart';

import '../../../Model/User_Management/shop_model.dart';

class AdminShop extends StatefulWidget {
  const AdminShop({super.key});

  @override
  State<AdminShop> createState() => _AdminShopState();
}

class _AdminShopState extends State<AdminShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal, // Allow scrolling if overflow occurs
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hello,",
                        style: TextStyle(fontSize: 22),
                      ),
                      const Text(
                        "Good Morning Team!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Unlock insights, track growth, and manage performance effortlessly.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 300), // Spacing for responsiveness
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
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6), // Padding for spacing
                        decoration: BoxDecoration(
                            color: Colors
                                .white, // Light background for better visibility
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 0.5,
                                color: Colors.grey) // Rounded corners
                            ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/profile/girl.png'),
                            ),
                            const SizedBox(
                                width: 10), // Space between avatar and text
                            const Text(
                              "Admin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allow tab scrolling
              child: Row(
                children: [
                  _buildTab("All Shop", isSelected: true),
                  _buildTab("Registered Shop"),
                  _buildTab("Accept Shop"),
                  _buildTab("Reject Shop"),
                  _buildTab("Add Shop"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Ensures table responsiveness
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: DataTable(
                    decoration: const BoxDecoration(color: Colors.white),
                    columns: [
                      _buildColumn('SL NO'),
                      _buildColumn('Owner Name'),
                      _buildColumn('Shop Name'),
                      _buildColumn('Floor'),
                      _buildColumn('Phone Number'),
                      _buildColumn('Email'),
                      _buildColumn('Edit/Delete'),
                    ],
                    rows: List.generate(
                      shops.length,
                      (index) {
                        final shop = shops[index];
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              (index + 1).toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataCell(Text(
                              shop.Owner_Name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataCell(Text(shop.Shop_Name)),
                            DataCell(Text(shop.Floor)),
                            DataCell(Text(shop.Phone_Number)),
                            DataCell(Text(shop.Email_ID)),
                            DataCell(Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff0A71CB)),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const SizedBox(
                                      width: 70,
                                      child: Center(child: Text("Edit")),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                    onPressed: () {
                                      print("Button pressed!");
                                    },
                                    child: const SizedBox(
                                      width: 70,
                                      child: Center(child: Text("Delete")),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
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
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTab(String title, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
