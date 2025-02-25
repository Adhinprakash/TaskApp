import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/view/login/login_screen.dart';

class InputTextField extends StatelessWidget {
    final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String svgIcon;
  final String? Function(String?)? validator;
   InputTextField({super.key, required this.controller, required this.hintText, required this.labelText, required this.svgIcon, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        suffix: SvgPicture.string(svgIcon),
        border: authOutlineInputBorder,
        enabledBorder: authOutlineInputBorder,
        focusedBorder: authOutlineInputBorder.copyWith(
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}