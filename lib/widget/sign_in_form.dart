import 'package:baby_stamp/constants/auth_input_decor.dart';
import 'package:baby_stamp/constants/common_size.dart';
import 'package:baby_stamp/screen/home_screen.dart';
import 'package:baby_stamp/widget/or_devider.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(commonGap),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: commonLargeGap),
            const Text(
              textAlign: TextAlign.center,
              "Instagram",
              style: TextStyle(
                  fontFamily: 'VeganStyle',
                  fontWeight: FontWeight.normal,
                  fontSize: 50),
            ),
            const SizedBox(height: commonLargeGap),
            TextFormField(
              controller: _emailController,
              decoration: textInputDeco("Email"),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: commonGap,
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: textInputDeco("Password"),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter a password';
                }
                if (text.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: commonSmallGap,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgotten Password?"))),
            const SizedBox(
              height: commonSmallGap,
            ),
            _submitButton(context),
            const SizedBox(
              height: commonSmallGap,
            ),
            const OrDivider(),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.blue,
              ),
              label: const Text("Login with Facebook"),
              icon: const Icon(Icons.facebook),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _submitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(commonSmallGap))),
        child: const Text(
          "Sign in",
          style: TextStyle(color: Colors.white),
        ));
  }
}
