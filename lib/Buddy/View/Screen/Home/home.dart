import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import 'BuddyActiveDeliveryPage.dart';
import 'BuddyProfile.dart';
import 'Buddy_completedeliveryfirstpage.dart';

class BuddyHomeScreen extends StatefulWidget {
  @override
  _BuddyHomeScreenState createState() => _BuddyHomeScreenState();
}

class _BuddyHomeScreenState extends State<BuddyHomeScreen> {
  String? selectedButton; // T// rack selec
  int currentIndex = 0; // Track active banner
  final PageController _pageController = PageController();
  List<String> bannerImages = [
    'assets/userblog1.png',
    'assets/userblog1.png',
    'assets/userblog1.png',
    'assets/userblog1.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }


  void _startAutoSlide() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentIndex + 1) % bannerImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }// ted action button

  void _onButtonPressed(String title, BuildContext context) {
    setState(() {
      selectedButton = title;
    });

    switch (title) {
      case "Assign":
        Navigator.push(context, MaterialPageRoute(builder: (context) => BuddyActiveDeliveryPage()));
        break;
      case "Active":
        Navigator.push(context, MaterialPageRoute(builder: (context) => BuddyActiveDeliveryPage()));
        break;
      case "Completed":
        Navigator.push(context, MaterialPageRoute(builder: (context) => BuddyCompleteDeliveryFirstScreen()));
        break;
    }
  }

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
                          Text("Kavya", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                      Spacer(),
                      SizedBox(width: 8),
                      Icon(Icons.notifications_on_sharp, size: 30, color: Colors.black45),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // **Image Slider**
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemCount: bannerImages.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          bannerImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  // **Indicator (Blue Dots)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(bannerImages.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          height: 10,
                          width: currentIndex == index ? 30 : 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: currentIndex == index ? Colors.blueAccent : Colors.black.withOpacity(0.4),
                          ),
                        ),
                      );
                    }),
                  ),SizedBox(height: 16),

                  // Quick Actions Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton("Assign", Icons.shopping_cart, context),
                      SizedBox(width: 20),
                      _buildActionButton("Completed", Icons.qr_code_scanner, context),
                      SizedBox(width: 20),
                      _buildActionButton("Active", Icons.info, context),
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

                  // Earnings Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: 200, width: 150, color: defaultBlue, child: earningsCard("Today Earnings", "₹1000")),
                      Container(height: 200, width: 150, color: defaultBlue, child: earningsCard("Total Earnings", "₹50000")),
                    ],
                  ),
                ]))));
  }

  Widget _buildActionButton(String title, IconData icon, BuildContext context) {
    bool isSelected = selectedButton == title;

    return GestureDetector(
      onTap: () => _onButtonPressed(title, context),
      child: Container(
        height: 100,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? Colors.blueAccent : Colors.blue[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

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
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

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
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
