import 'package:flutter/material.dart';

class Buddy extends StatefulWidget {
  const Buddy({super.key});

  @override
  State<Buddy> createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("buddy")),
    );
  }
}
