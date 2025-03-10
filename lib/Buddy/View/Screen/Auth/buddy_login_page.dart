import 'package:flutter/material.dart';

import '../../../../Shop/Bottomnav/Shop_Bottom.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';





class BuddyLoginPage extends StatefulWidget {
  const BuddyLoginPage({super.key});

  @override
  State<BuddyLoginPage> createState() => _BuddyLoginPageState();
}

class _BuddyLoginPageState extends State<BuddyLoginPage> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Image.asset(
                  'assets/logo.png',
                  width: 160,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome to Mall Buddy!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28, // Adjust size as needed
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Adjust color if needed
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomTextForm(hintText: "Enter your email"),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextForm(hintText: "Enter your password"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                          ),
                          Text("Remember Me"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: defaultBlue,
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBarExample()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 220),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue, // You can change the color
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New to Mall Buddy ?",
                            style: TextStyle(
                              color:
                              Colors.black87, // You can customize the color
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: defaultBlue, // You can customize the color
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
