import 'package:baby_stamp/widget/fade_stack.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedForms = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 40,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedForms == 0
                ? const Text("Don't have an account?")
                : const Text("Aleady have an account?"),
            // const Text("Aleady have an acount?"),
            TextButton(
              onPressed: () {
                setState(() {
                  if (selectedForms == 0) {
                    selectedForms = 1;
                  } else {
                    selectedForms = 0;
                  }
                });
              },
              child: selectedForms == 0
                  ? const Text("Sign Up")
                  : const Text("Sign In"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          FadeStack(selectedForms: selectedForms),
        ]),
      ),
    );
  }
}
