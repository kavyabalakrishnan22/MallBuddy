import 'package:flutter/material.dart';


import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';
import '../Bottomnav/Bottom.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                        "Create your Mall Buddy Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24, // Adjust size as needed
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Adjust color if needed
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      CustomTextForm(hintText: "User name"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextForm(hintText: "Email address"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextForm(hintText: "Phone number"),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextForm(hintText: "Password"), const SizedBox(
                        height: 15,
                      ),
                      CustomTextForm(hintText: "Confirm Password"),
                      const SizedBox(
                        height: 25,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: defaultBlue,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBarExample()));

                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
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
                            "Sign in",
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
