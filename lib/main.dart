import 'package:flutter/material.dart';

import 'Admin/view/Auth/Admin_Login.dart';
import 'Buddy/View/Screen/Home/BuddyActiveDeliveryPage.dart';
import 'Buddy/View/Screen/Home/Buddy_completedelivery.dart';
import 'Buddy/View/Screen/Home/Buddy_completedeliveryfirstpage.dart';
import 'Buddy/View/Screen/Home/Buddy_scan.dart';
import 'Buddy/View/Screen/Auth/buddy_signup_page.dart';
import 'Shop/Bottomnav/Shop_Bottom.dart';
import 'Shop/View/Screens/Checkout.dart';
import 'Shop/View/Screens/Home/shop_home_page.dart';
import 'Shop/View/Screens/Shop_Userselectparking.dart';
import 'Shop/View/Screens/auth/shop_login.dart';
import 'Shop/View/Screens/auth/shop_signup_page.dart';
import 'Shop/View/Screens/paymentsuccessful.dart';
import 'Shop/View/Screens/shop_active_delivery.dart';
import 'Shop/View/Screens/shop_assign_buddy.dart';

import 'Shop/View/Screens/shop_payment_successfull.dart';
import 'Shop/View/Screens/shop_select_parking.dart';
import 'Shop/View/Screens/shoporderhistory.dart';
import 'User/View/Screens/Bottomnav/Bottom.dart';
import 'User/View/Screens/Bottomnav/Bottomnav.dart';
import 'User/View/Screens/Home/User_Home_page.dart';
import 'User/View/Screens/Home/User_shop.dart';
import 'User/View/Screens/Home/listinvoices.dart';
import 'User/View/Screens/Home/paymentsuccess.dart';
import 'User/View/Screens/Home/profile.dart';
import 'User/View/Screens/Home/scan.dart';
import 'User/View/Screens/Splash/onboardingpage_one.dart';
import 'User/View/Screens/Splash/onboardingpage_three.dart';
import 'User/View/Screens/Splash/onboardingpage_two.dart';
import 'User/View/Screens/auth/User_login_page.dart';
import 'User/View/Screens/auth/forgotpassword.dart';
import 'User/View/Screens/auth/User_signup_page.dart';
import 'User/View/Screens/completedelivery.dart';
import 'User/View/Screens/myorders.dart';
import 'User/View/Screens/notification.dart';
import 'User/View/Screens/orderhistory.dart';
import 'User/View/Screens/recheckpayment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ShopSignupPage(),
    );
  }
}
