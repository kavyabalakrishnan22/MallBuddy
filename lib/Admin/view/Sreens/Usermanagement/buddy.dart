import 'package:flutter/material.dart';
import '../../../Model/User_Management/Buddy_model.dart';
import '../../../Model/User_Management/Customer_model.dart';

class AdminBuddy extends StatefulWidget {
  const AdminBuddy({super.key});

  @override
  State<AdminBuddy> createState() => _AdminBuddyState();
}

class _AdminBuddyState extends State<AdminBuddy> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedFloor = 0;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
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
            _buildHeader(),
            const SizedBox(height: 20),
            _buildTabBar(),
            const SizedBox(height: 20),
            _buildFloorSelection(),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildShopTable("All Buddy"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Hello,", style: TextStyle(fontSize: 22)),
            Text("Good Morning Team!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              "Unlock insights, track growth, and manage performance effortlessly.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
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
          Tab(text: "All Buddys"),
        ],
      ),
    );
  }

  Widget _buildFloorSelection() {
    List<String> floors = ["Ground Floor", "First Floor", "Second Floor", "Third Floor"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(floors.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedFloor = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: selectedFloor == index ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              floors[index],
              style: TextStyle(
                color: selectedFloor == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
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
            _buildColumn('Buddy ID'),
            _buildColumn('Buddy Details'),
            _buildColumn('Edit'),
            _buildColumn('Delete'),
          ],
          rows: List.generate(
            Buddys.length,
                (index) {
              final Buddy = Buddys[index];
              return DataRow(
                cells: [
                  DataCell(Text((index + 1).toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(Buddy.Rider_ID, overflow: TextOverflow.ellipsis)),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Buddy.Rider_Name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                        Text(Buddy.Gender, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                        Text(Buddy.Phone_Number, overflow: TextOverflow.ellipsis),
                        Text(Buddy.Email, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
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
        style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildToggleButton(String text, int index, bool isEdit) {
    bool isSelected = isEdit ? (selectedEdit[index] ?? false) : (selectedDelete[index] ?? false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isSelected ? Colors.blue : Colors.white),
          foregroundColor: MaterialStateProperty.all(isSelected ? Colors.white : Colors.black),
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
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this buddy?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Buddys.removeAt(index); // Remove buddy from the list
                  selectedDelete.remove(index); // Remove selection state
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

}