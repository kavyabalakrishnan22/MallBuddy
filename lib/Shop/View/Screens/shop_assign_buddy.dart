import 'package:flutter/material.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

class AssignRidersPage extends StatelessWidget {
  final List<Map<String, String>> riders = [
    {
      "name": "Adhi",
      "id": "Jack01",
      "contact": "8921698037",
      "image": "assets/profile/rider.png"
    },
    {
      "name": "Aman",
      "id": "Jack01",
      "contact": "8921698037",
      "image": "assets/profile/rider.png"
    },
    {
      "name": "Arathi",
      "id": "Jack01",
      "contact": "8921698037",
      "image": "assets/profile/rider.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Assign"),
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        // elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available Riders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: riders.length,
                itemBuilder: (context, index) {
                  return RiderCard(
                    name: riders[index]["name"]!,
                    id: riders[index]["id"]!,
                    contact: riders[index]["contact"]!,
                    imagePath: riders[index]["image"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RiderCard extends StatelessWidget {
  final String name, id, contact, imagePath;
  const RiderCard({
    required this.name,
    required this.id,
    required this.contact,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name (Rider ID : $id)",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Contact : $contact",
                    style: const TextStyle(color: Colors.black54),
                  ),SizedBox(height: 10,),Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: defaultBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Book",style: TextStyle(color: Colors.white,fontSize:18),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue.shade300,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   onPressed: () {},
            //   child: const Text("Book"),
            // ),
          ],
        ),
      ),
    );
  }
}
