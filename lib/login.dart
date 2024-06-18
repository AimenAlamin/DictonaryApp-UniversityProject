import 'package:flutter/material.dart';
import 'package:flutter_application_18/firstPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController userpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/loginimg.png',
            width: 300,
            height: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Enter your details",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                hintText: "Username",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              controller: userpassword,
              obscureText: true, // for password field
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                hintText: "Password",
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              // Check credentials
              if (userpassword.text == '12345') {
                // Navigate to HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                // Show error or handle incorrect password
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Error"),
                    content:
                        const Text("Incorrect password. Please try again."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Sign In",
              style: TextStyle(fontSize: 23),
            ),
          ),
        ],
      ),
    );
  }
}
