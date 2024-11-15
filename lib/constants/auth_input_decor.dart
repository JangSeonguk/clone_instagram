import 'package:baby_stamp/constants/common_size.dart';
import 'package:flutter/material.dart';

InputDecoration textInputDeco(String hint) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[100],
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey),
    enabledBorder: activeInputBorder(Colors.grey, 1),
    errorBorder: errorInputBorder(),
    focusedBorder: activeInputBorder(Colors.blueAccent, 3),
    focusedErrorBorder: errorInputBorder(),
  );
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(commonSmallGap));
}

OutlineInputBorder activeInputBorder(Color color, double width) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(commonSmallGap));
}
