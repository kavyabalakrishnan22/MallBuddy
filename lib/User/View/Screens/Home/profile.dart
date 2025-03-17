import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';

import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../notification.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  void initState() {
    super.initState();
    controllers = List.generate(contactDetails.length, (index) {
      return TextEditingController(text: contactDetails[index]["value"]);
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildSelectableContactRow(String label, int index) {
    bool isEditing = selectedContactIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedContactIndex = isEditing ? -1 : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(label,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Expanded(
                  flex: 3,
                  child: isEditing
                      ? TextField(
                          controller: controllers[index],
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          onSubmitted: (newValue) {
                            setState(() {
                              contactDetails[index]["value"] = newValue;
                              selectedContactIndex = -1;
                            });
                          },
                        )
                      : Text(contactDetails[index]["value"]!,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black)),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit,
                      size: 16, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        contactDetails[index]["value"] =
                            controllers[index].text;
                        selectedContactIndex = -1;
                      } else {
                        selectedContactIndex = index;
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.black, thickness: 0.3),
          ],
        ),
      ),
    );
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
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                  ),
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
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : const AssetImage("assets/profile/girl.png")
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
                        // const CircleAvatar(
                        //   radius: 70,
                        //   backgroundImage:
                        //       AssetImage("assets/profile/girl.png"),
                        // ),
                        const SizedBox(height: 8),
                        const Text("Kavya Krishnan K K",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: const Text("Contact Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        ...List.generate(
                            contactDetails.length,
                            (index) => _buildSelectableContactRow(
                                contactDetails[index]["label"]!, index)),
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
                            final Authbloc = BlocProvider.of<AuthBloc>(context);
                            Authbloc.add(SigOutEvent());
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
