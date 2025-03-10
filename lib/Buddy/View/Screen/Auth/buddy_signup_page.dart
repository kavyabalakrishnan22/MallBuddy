import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../User/View/Screens/Bottomnav/Bottom.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';

class BuddySignupPage extends StatefulWidget {
  const BuddySignupPage({super.key});

  @override
  State<BuddySignupPage> createState() => _BuddySignupPageState();
}

class _BuddySignupPageState extends State<BuddySignupPage> {
  bool rememberMe = false;
  final TextEditingController dobController = TextEditingController();

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Set a reasonable past date limit
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate); // Format date
      });
    }
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Image.asset('assets/logo.png', width: 150),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Create your Mall Buddy Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 35),
                       CustomTextForm(hintText: "User name"),
                      const SizedBox(height: 15),

                      // Date of Birth Field
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: CustomTextForm(
                            hintText: "Date of Birth",
                            controller: dobController,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                      CustomTextForm(hintText: "Email address"),
                      const SizedBox(height: 15),
                       CustomTextForm(hintText: "Phone number"),
                      const SizedBox(height: 15),
                       CustomTextForm(hintText: "Password"),
                      const SizedBox(height: 15),
                       CustomTextForm(hintText: "Confirm Password"),
                      const SizedBox(height: 25),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: defaultBlue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBarExample(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // Navigate to sign-in screen
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: defaultBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
