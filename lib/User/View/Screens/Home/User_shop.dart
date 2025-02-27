import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Map<String, dynamic>> shopList = [
    {
      "icon": "assets/adidas.png",
      "name": "Adidas",
      "subtitle": "Sportswear",
    },
    {
      "icon": "assets/nesto.png",
      "name": "Nesto",
      "subtitle": "Supermarket",
    },
    {
      "icon": "assets/zara.png",
      "name": "Zara",
      "subtitle": "Fashion",
    },
    {
      "icon": "assets/adidas.png",
      "name": "Adidas",
      "subtitle": "Sportswear",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  prefixIcon: Icon(Icons.search, color: Colors.black), // Search Icon inside TextFormField
                  filled: true,
                  fillColor: Colors.grey[200], // Background color
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8), // Space between widgets
            // Filter Button
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.black),
              onPressed: () {
                // Implement filter functionality
              },
            ),
            // Sort Button
            IconButton(
              icon: Icon(Icons.sort, color: Colors.black),
              onPressed: () {
                // Implement sort functionality
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.7, // Adjusted for subtitle
              ),
              itemCount: shopList.length,
              itemBuilder: (context, index) {
                return ShopGridViewItem(
                  icon: shopList[index]["icon"],
                  name: shopList[index]["name"],
                  subtitle: shopList[index]["subtitle"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShopGridViewItem extends StatelessWidget {
  final String icon;
  final String name;
  final String subtitle;

  const ShopGridViewItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  icon,
                  fit: BoxFit.contain, // Keeps image centered
                  width: double.infinity, // Adjusted width
                  height: double.infinity,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Left-align text
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2), // Small gap between title & subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
