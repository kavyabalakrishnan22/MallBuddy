import 'package:flutter/material.dart';
import '../../../../Model/User_Management/shop_model.dart';

class RegisteredShop extends StatefulWidget {
  const RegisteredShop({super.key});

  @override
  State<RegisteredShop> createState() => _RegisteredShopState();
}

class _RegisteredShopState extends State<RegisteredShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text("Registered Shops"),
      //   // backgroundColor: Colors.blue,
      // ),
      body: _buildShopTable("Registered Shops"),
    );
  }

  // Function to build shop tables for each tab
  Widget _buildShopTable(String title) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: DataTable(dataRowMaxHeight: 100,
          decoration: const BoxDecoration(color: Colors.white),
          columns: [
            _buildColumn('SL NO'),
            _buildColumn('Owner Details'),
            _buildColumn('Shop Name'),
            _buildColumn('Floor'),
            // _buildColumn('Phone Number'),
            // _buildColumn('Email'),
            _buildColumn('Accept/Reject'),
          ],
          rows: List.generate(
            shops.length,
                (index) {
              final shop = shops[index];
              return DataRow(
                cells: [
                  DataCell(Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(Column(
                    children: [
                      Text(
                        shop.Owner_Name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),Text(shop.Phone_Number),Text(shop.Email_ID)
                    ],
                  )),
                  DataCell(Text(shop.Shop_Name)),
                  DataCell(Text(shop.Floor)),
                  // DataCell(Text(shop.Phone_Number)),
                  // DataCell(Text(shop.Email_ID)),
                  DataCell(Row(
                  children: [
                  _buildOutlinedButton("Accept", Colors.green, Colors.green, () {
                  print("Accept button pressed!");
                  }),
                  const SizedBox(width: 10),
                  _buildOutlinedButton("Reject", Colors.red, Colors.red, () {
                  print("Reject button pressed!");
                  }),
                  ],
                  )),

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
          fontSize: 16,
        ),
      ),
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
