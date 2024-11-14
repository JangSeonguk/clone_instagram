import 'package:baby_stamp/screen/profile_screen.dart';
import 'package:baby_stamp/widget/sign_in_form.dart';
import 'package:baby_stamp/widget/sign_up_form.dart';
import 'package:flutter/material.dart';

class FadeStack extends StatefulWidget {
  final int selectedForms;

  const FadeStack({super.key, required this.selectedForms});
  @override
  State<FadeStack> createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack>
    with SingleTickerProviderStateMixin {
  List<Widget> forms = [const SignUpForm(), const SignInForm()];

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: duration);
    _animationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FadeStack oldWidget) {
    if (widget.selectedForms != oldWidget.selectedForms) {
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IndexedStack(
        index: widget.selectedForms,
        children: forms,
      ),
    );
  }
}
