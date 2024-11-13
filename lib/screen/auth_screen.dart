import 'package:baby_stamp/screen/profile_screen.dart';
import 'package:baby_stamp/widget/sign_in_form.dart';
import 'package:baby_stamp/widget/sign_up_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  List<Widget> forms = [
    const SignUpForm(),
    const SignInForm(),
  ];
  int selectedForms = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          IndexedStack(
            index: selectedForms,
            children: forms,
          ),
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
            child: const Text("go to Sign up"),
          ),
        ]),
      ),
    );
  }
}
