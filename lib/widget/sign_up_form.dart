import 'package:baby_stamp/constants/common_size.dart';
import 'package:baby_stamp/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //텍스트가 올바른지 확인할 수 있도록 폼키를 사용함.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    //모든 컨트롤러는 dispose해야한다. 메모리 누수 현상 방지
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              decoration: _textInputDeco("Email"),
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
              decoration: _textInputDeco("Password"),
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
              height: commonGap,
            ),
            TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration: _textInputDeco("Conform Password"),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (text != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }),
            const SizedBox(
              height: commonGap,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(commonSmallGap))),
                child: const Text(
                  "Join",
                  style: TextStyle(color: Colors.white),
                )),
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 20),
                  child: const Divider(
                    height: 50,
                  ),
                )),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 10),
                  child: const Divider(
                    height: 50,
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _textInputDeco(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: _activeInputBorder(Colors.grey, 1),
      errorBorder: _errorInputBorder(),
      focusedBorder: _activeInputBorder(Colors.blueAccent, 3),
      focusedErrorBorder: _errorInputBorder(),
    );
  }

  OutlineInputBorder _errorInputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(commonSmallGap));
  }

  OutlineInputBorder _activeInputBorder(Color color, double width) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.circular(commonSmallGap));
  }
}
