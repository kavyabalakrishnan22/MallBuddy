import 'package:flutter/material.dart';
import 'package:mall_bud/Shop/View/Screens/shop_select_parking.dart';

class UserListSelectparking extends StatefulWidget {
  const UserListSelectparking({super.key});

  @override
  State<UserListSelectparking> createState() => _UserListSelectparkingState();
}

class _UserListSelectparkingState extends State<UserListSelectparking> {
  final List<Map<String, String>> users = [
    {
      "name": "Kavya",
      "email": "kavyabalakrishnan2018@gmail.com",
      "contact": "8921669037",
      "image": "assets/profile/girl.png",
    },
    {
      "name": "Theertha",
      "email": "theertha@gmail.com",
      "contact": "8921669037",
      "image": "assets/profile/girl.png",
    },
    {
      "name": "Anusree",
      "email": "anusree@gmail.com",
      "contact": "8921669037",
      "image": "assets/profile/girl.png",
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Users",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
        decoration: const InputDecoration(
          hintText: "Search here...",
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    List<Map<String, String>> filteredUsers = users
        .where((user) =>
    user["name"]!.toLowerCase().contains(searchQuery) ||
        user["email"]!.toLowerCase().contains(searchQuery))
        .toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        return _buildUserCard(filteredUsers[index]);
      },
    );
  }

  Widget _buildUserCard(Map<String, String> user) {
    return Card(
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    user["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user["name"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Email: ${user["email"]!}"),
                      Text("Contact: ${user["contact"]!}"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildSelectButton(user),
          ],
        ),
      ),
    );
  }


  Widget _buildSelectButton(Map<String, String> user) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvoiceFormPage(
                name: user["name"]!,
                email: user["email"]!,
                contact: user["contact"]!,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text("Select", style: TextStyle(color: Colors.white)),
      ),
    );
  }





}
