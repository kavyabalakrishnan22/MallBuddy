import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';

class ShopSignupPage extends StatefulWidget {
  const ShopSignupPage({super.key});

  @override
  State<ShopSignupPage> createState() => _ShopSignupPageState();
}

class _ShopSignupPageState extends State<ShopSignupPage> {
  bool rememberMe = false;
  String? selectedFloor; // Store selected floor
  File? _imageFile;

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
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
            SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Create your Mall Buddy Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),const SizedBox(height: 15),
                      const SizedBox(height: 15),

                      // **Image Upload Section**
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: _imageFile == null
                              ? const Center(
                            child: Text(
                              "Tap to upload image",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _imageFile!,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),                      SizedBox(height: 20),

                      // **Row with Shop Name and Floor Selection**
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomTextForm(hintText: "Shop name"),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedFloor, // Show selected value
                                  hint: Text(
                                    "Select floor",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    "Ground Floor",
                                    "First Floor",
                                    "Second Floor",
                                    "Third Floor",
                                    "Forth Floor"
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedFloor =
                                          newValue; // Update selected floor
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 15),
                      CustomTextForm(hintText: "User name"),
                      const SizedBox(height: 15),
                      CustomTextForm(hintText: "Email address"),
                      const SizedBox(height: 15),
                      CustomTextForm(hintText: "Phone number"),
                      const SizedBox(height: 15),
                      CustomTextForm(hintText: "Password"),
                      const SizedBox(height: 15),
                      CustomTextForm(hintText: "Confirm Password"),
                      const SizedBox(height: 25),

                      // **Register Button**
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: defaultBlue,
                        onPressed: () {},
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // **Sign In Prompt**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Sign in",
                            style: TextStyle(
                              color: defaultBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
