import 'package:flutter/material.dart';



class AdminLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // Left Image Section
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      image: const DecorationImage(
                        image: AssetImage('assets/admin/adminlogin.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Right Login Form Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset('assets/logo.png', height: 50),
                              const SizedBox(height: 20),
                              const Text(
                                "Welcome Back!",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              const Text("Login as Admin",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (value) {}),
                                const Text("Remember me"),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Forgot password?"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text("Login",
                                style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
