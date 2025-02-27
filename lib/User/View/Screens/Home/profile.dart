import 'package:flutter/material.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';
import '../myorders.dart';
import '../notification.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedContactIndex = -1;
  int selectedIndex = -1;

  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.shopping_bag, "title": "My Orders"},
    {"icon": Icons.lock, "title": "Privacy & Policy"},
    {"icon": Icons.article, "title": "Terms & Conditions"},
    {"icon": Icons.logout, "title": "Log Out", "isLogout": true},
  ];

  final List<Map<String, String>> contactDetails = [
    {"label": "Email", "value": "kavyabalakrishnan2018@gmail.com"},
    {"label": "Mobile", "value": "8921689037"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            const CircleAvatar(radius: 70, backgroundImage: AssetImage("assets/profile/girl.png")),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                child: IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Kavya Krishnan K K", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 10),
                          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: const [
                              Text("Vehicle Number", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                              Text("KL 57 W 471", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Align(alignment: Alignment.centerLeft, child: const Text("Contact Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                        const SizedBox(height: 4),
                        Column(children: List.generate(contactDetails.length, (index) {
                          return _buildSelectableContactRow(contactDetails[index]["label"]!, contactDetails[index]["value"]!, index);
                        })),
                        const SizedBox(height: 4),
                        Column(children: List.generate(menuItems.length, (index) {
                          return _buildMenuOption(menuItems[index]["icon"], menuItems[index]["title"], index, isLogout: menuItems[index]["isLogout"] ?? false);
                        })),
                        const SizedBox(height: 20),
                      ],
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

  Widget _buildSelectableContactRow(String label, String value, int index) {
    bool isSelected = selectedContactIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() { selectedContactIndex = index; });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 2, child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text(value, textAlign: TextAlign.right, style: TextStyle(fontSize: 14, color: isSelected ? Colors.blue : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))),
                IconButton(icon: Icon(Icons.edit, size: 16, color: isSelected ? Colors.blue : Colors.black), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.black, thickness: 0.3),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, int index, {bool isLogout = false}) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() { selectedIndex = index; });
        if (title == "My Orders") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300)),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.blue : (isLogout ? Colors.red : Colors.black)),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isSelected ? Colors.blue : (isLogout ? Colors.red : Colors.black))),
          ],
        ),
      ),
    );
  }
}
