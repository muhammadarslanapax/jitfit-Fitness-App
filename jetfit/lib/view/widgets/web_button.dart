import 'package:flutter/material.dart';

class WebButton extends StatelessWidget {
  const WebButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.width,
  });

  final String text;
  final Color color;
  final double width;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return SizedBox(
      width: width,
      height: height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(60, 50),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
