import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Widgets/Constants/Loading.dart';
import 'Shop_ProfilePage.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      const SizedBox(height: 30),
      Row(
        children: [
          SizedBox(width: 20),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('assets/logo.png'),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello!", style: TextStyle(fontSize: 18)),
              BlocBuilder<ShopAuthBloc, ShopAuthState>(
                  builder: (context, state) {
                if (state is Shoploading) {
                  return Center(child: Loading_Widget());
                } else if (state is ShopByidLoaded) {
                  final user = state.Userdata;
                  return Text(' ${user.Ownername ?? ''}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                }
                return SizedBox();
              })
            ],
          ),
          Spacer(),
          SizedBox(width: 10),
          Icon(Icons.notifications_on_sharp, size: 30, color: Colors.black45),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShopProfilePage()), // Navigate to ProfilePage
              );
            },
            child: CircleAvatar(
              radius: 20, // Adjust size as needed
              backgroundImage: AssetImage("assets/profile/girl.png"),
              backgroundColor: Colors
                  .transparent, // Optional: Make the background transparent
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      SizedBox(height: 16),

      // Today Delivery Section
      Row(
        children: [
          Text(
            "Today Delivery",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: 10),

      // Delivery Status Card
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: defaultBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            deliveryStatusItem("Pending Delivery", "4", Icons.access_time),
            deliveryStatusItem("Done Delivery", "10", Icons.check_circle),
          ],
        ),
      ),
      SizedBox(height: 16),

      // Quick Actions Row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          quickActionItem(Icons.local_shipping, "Delivery\nParking lot"),
          quickActionItem(Icons.directions_bike, "Active\nDelivery"),
          quickActionItem(Icons.done_all, "Completed\nDelivery"),
          quickActionItem(Icons.list_alt, "Order\nStatus"),
        ],
      ),
      SizedBox(height: 16),

      // Earnings Section
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 200,
              width: 150,
              color: defaultBlue,
              child: earningsCard("Today Earnings", "₹1000")),
          Container(
              height: 200,
              width: 150,
              color: defaultBlue,
              child: earningsCard("Total Earnings", "₹50000")),
        ],
      ),
    ]))));
  }

  // Widget for Delivery Status
  Widget deliveryStatusItem(String title, String count, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Widget for Quick Actions
  Widget quickActionItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.black),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget for Earnings Card
  Widget earningsCard(String title, String amount) {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
