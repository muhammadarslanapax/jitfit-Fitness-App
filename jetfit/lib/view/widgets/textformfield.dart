import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';

class Textformfield extends StatelessWidget {
  final String? hinttext;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardtype;
  final TextInputAction? inputaction;
  final String? Function(String?)? validation;
  final bool abscureText;
  final int? maxline;
  void Function(String)? onChanged;
  final TextEditingController? controller;

  Textformfield({
    Key? key,
    this.maxline,
    this.hinttext,
    this.inputaction,
    this.onChanged,
    this.keyboardtype,
    this.prefixIcon,
    this.suffixIcon,
    this.validation,
    this.controller,
    required this.abscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: abscureText,
      onChanged: onChanged,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.black,
      keyboardType: keyboardtype,
      maxLines: maxline,
      autofocus: false,
      textInputAction: inputaction,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 10),
        border: InputBorder.none,
        filled: true,
        prefixIcon: prefixIcon,
        suffix: suffixIcon,
        fillColor: Colors.grey.shade200,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyThemeData.background,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyThemeData.redColour,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyThemeData.redColour,
            width: 2,
          ),
        ),
      ),
      validator: validation,
    );
  }
}
