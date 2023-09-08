import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? description;
  final int? age;

  final TextEditingController controller;
  final String? hint;
  final String? labell;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final Color? fillcolor;

  CustomFormField({
    super.key,
    this.description,
    this.age,
    required this.controller,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hint,
    this.labell,
    this.fillcolor,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.black),
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            fillColor: fillcolor,
            filled: true,
            hintText: hint,
            contentPadding: EdgeInsets.all(7),
            border: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey, width: 1.0)),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}
