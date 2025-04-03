import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';

class BuddyEditProfilePage extends StatefulWidget {
  BuddyEditProfilePage({required this.image});

  final image;

  @override
  _BuddyEditProfilePageState createState() => _BuddyEditProfilePageState();
}

class _BuddyEditProfilePageState extends State<BuddyEditProfilePage> {
  TextEditingController nameController =
      TextEditingController(text: "Charlotte King");
  TextEditingController emailController =
      TextEditingController(text: "johnkinggraphics@gmail.com");
  TextEditingController phoneController =
      TextEditingController(text: "+91 6895312");

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.green),
            onPressed: () {
              // Save profile changes
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
        listener: (context, state) {
          if (state is BuddyProfileImageSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Profile Picture with Edit Icon
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            60), // Ensures a rectangular shape
                        child: Image.network(
                          widget.image,
                          width: 100, // Adjusted width
                          height: 100, // Adjusted height
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return state is BuddyProfileImageLoading
                                ? Loading_Widget()
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .grey[300], // Placeholder background
                                      borderRadius: BorderRadius
                                          .zero, // Ensures rectangle shape
                                    ),
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey[600],
                                    ),
                                  );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.read<BuddyAuthBloc>()
                              ..add(BuddyPickAndUploadImageEvent());
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.camera_alt,
                                color: Colors.white, size: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  child: state is BuddyProfileImageLoading
                      ? Column(
                          children: [
                            Loading_Widget(),
                            Text("Profile Updating.....")
                          ],
                        )
                      : Text(""),
                ),
                SizedBox(height: 20),

                // Editable Fields inside Containers
                buildEditableField("Name", nameController, false),
                buildEditableField("E-mail Address", emailController, false),
                buildEditableField("Phone Number", phoneController, false),
              ],
            ),
          );
        },
      ),
    );
  }

  // Custom Widget for Editable Fields
  Widget buildEditableField(
      String label, TextEditingController controller, bool isPassword) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        onTap: () {
          if (controller.text != "") {
            controller.clear();
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
