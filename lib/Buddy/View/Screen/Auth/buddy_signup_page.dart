import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/Bloc/Buddy_Authbloc/Buddyauthmodel/Buddyauthmodel.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';

class Buddysignupwrapper extends StatelessWidget {
  const Buddysignupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuddyAuthBloc(),
      child: BuddySignupPage(),
    );
  }
}

class BuddySignupPage extends StatefulWidget {
  const BuddySignupPage({super.key});

  @override
  State<BuddySignupPage> createState() => _BuddySignupPageState();
}

class _BuddySignupPageState extends State<BuddySignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _registerUser() {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select your gender")),
        );
        return;
      }

      BuddyModel user = BuddyModel(
        name: _usernameController.text,
        Gender: _genderController.text,
        Dob: dobController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,

      );

      context.read<BuddyAuthBloc>().add(BuddySignupEvent(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        if (state is BuddyAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          });
        }
        if (state is BuddyAuthenticatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: defaultBlue,
          body: SafeArea(
            child: Form(
              key: _formKey,
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
                        child: ListView(
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
                            const SizedBox(height: 30),
                            CustomTextForm(
                              hintText: "User name",
                              controller: _usernameController,
                              validator: (value) => value!.isEmpty ? "Username is required" : null,
                            ),
                            const SizedBox(height: 15),

                            // Date of Birth Field
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: CustomTextForm(
                                  hintText: "Date of Birth",
                                  controller: dobController,
                                  validator: (value) => value!.isEmpty ? "Date of birth is required" : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Gender Dropdown
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  hint: const Text("Select Gender", style: TextStyle(color: Colors.black54)),
                                  isExpanded: true,
                                  items: ["Male", "Female", "Other"].map((String value) {
                                    return DropdownMenuItem<String>(value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedGender = newValue;
                                      _genderController.text = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),

                            CustomTextForm(
                              hintText: "Email address",
                              controller: _emailController,
                              validator: (value) =>
                              value!.isEmpty || !value.contains("@") ? "Enter a valid email" : null,
                            ),
                            const SizedBox(height: 15),

                            CustomTextForm(
                              hintText: "Phone number",
                              controller: _phoneController,
                              validator: (value) =>
                              value!.length != 10 ? "Enter a valid 10-digit phone number" : null,
                            ),
                            const SizedBox(height: 15),

                            CustomTextForm(
                              hintText: "Password",
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) =>
                              value!.length < 6 ? "Password must be at least 6 characters" : null,
                            ),
                            const SizedBox(height: 15),

                            CustomTextForm(
                              hintText: "Confirm Password",
                              controller: _confirmPasswordController,
                              obscureText: true,
                              validator: (value) =>
                              value != _passwordController.text ? "Passwords do not match" : null,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                height:50,
                                child: Column(
                                  children: [
                                    state is BuddyAuthloading
                                        ? Text("Registering...")
                                        : Text(""),
                                    state is BuddyAuthloading
                                        ? Loading_Widget()
                                        : Text(""),
                                  ],
                                )),

                            // Register Button
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              color: defaultBlue,
                              onPressed: _registerUser,
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: defaultBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
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
          ),
        );
      },
    );
  }
}
