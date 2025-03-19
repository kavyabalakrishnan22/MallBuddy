import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Widgets/Constants/Loading.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BuddyProfilePage extends StatefulWidget {
  const BuddyProfilePage({super.key});

  @override
  State<BuddyProfilePage> createState() => _BuddyProfilePageState();
}

class _BuddyProfilePageState extends State<BuddyProfilePage> {
  int selectedContactIndex = -1;
  int selectedIndex = -1;
  List<TextEditingController> controllers = [];

  final List<Map<String, String>> contactDetails = [
    {"label": "Email", "value": "kavyabalakrishnan2018@gmail.com"},
    {"label": "Mobile", "value": "8921689037"},
  ];

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("Choose an option"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text("Upload Photo"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text("Take Photo"),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              setState(() {
                _profileImage = null;
              });
              Navigator.pop(context);
            },
            child: const Text("Remove Photo"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  @override
  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Profile",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  // IconButton(
                  //   icon: const Icon(Icons.notifications, color: Colors.white),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => NotificationScreen()));
                  //   },
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        BlocBuilder<BuddyAuthBloc, BuddyAuthState>(
                          builder: (context, state) {
                            if (state is Buddyloading) {
                              return SizedBox(
                                height: 200,
                                child: Loading_Widget(),
                              );
                              Center(child: CircularProgressIndicator());
                            } else if (state is BuddyByidLoaded) {
                              final user = state.Userdata;
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage: _profileImage != null
                                            ? FileImage(_profileImage!)
                                            :  AssetImage(
                                                    "assets/profile/girl.png")
                                                as ImageProvider,
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: GestureDetector(
                                          onTap: _showImagePickerOptions,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: defaultBlue,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(8),
                                            child: const Icon(
                                              CupertinoIcons.camera,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${user.name ?? ''}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 20),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Text("Contact Details",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  ListTile(
                                    title: Text("Email"),
                                    subtitle: Text('${user.email ?? ''}'),
                                  ),
                                  ListTile(
                                    title: Text("Mobile"),
                                    subtitle: Text('Name: ${user.phone ?? ''}'),
                                  ),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              // border: Border.all(
                              //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text("My Orders",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            print("object");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              // border: Border.all(
                              //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text("Privacy and policy",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            print("object");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              // border: Border.all(
                              //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.article, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text("Terms and Condition",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            final BuddyAuthbloc =
                                BlocProvider.of<BuddyAuthBloc>(context);
                            BuddyAuthbloc.add(BuddySigOutEvent());
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/login",
                              (route) => false,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              // border: Border.all(
                              //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.login, color: Colors.red),
                                const SizedBox(width: 10),
                                Text("Logout",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                              ],
                            ),
                          ),
                        ),
                        // BlocBuilder<BuddyAuthBloc, BuddyAuthState>(
                        //   builder: (context, state) {
                        //     if (state is Buddyloading) {
                        //       return const Center(
                        //           child: CircularProgressIndicator());
                        //     } else if (state is BuddyByidLoaded) {
                        //       final user = state.Userdata;
                        //       return Column(
                        //         children: [
                        //           Text('Name: ${user.name ?? ''}'),
                        //           Text('Email: ${user.email ?? ''}'),
                        //           Text('Phone: ${user.phone ?? ''}'),
                        //           Text('Status: ${user.status ?? ''}'),
                        //         ],
                        //       );
                        //     } else if (state is Buddyerror) {
                        //       return Center(child: Text(state.error));
                        //     }
                        //     return const SizedBox.shrink();
                        //   },
                        // ),
                        const SizedBox(height: 4),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
