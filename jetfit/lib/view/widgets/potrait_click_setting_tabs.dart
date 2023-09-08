import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';

class IsClicksettingTabs extends StatelessWidget {
  const IsClicksettingTabs({
    super.key,
    required this.height,
    required this.text,
    required this.myIndex,
    required this.objconditionIndex,
    required this.width,
  });

  final double height;
  final double width;
  final int objconditionIndex;
  final int myIndex;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyThemeData.onBackground.withOpacity(0.4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              text,
              style: TextStyle(
                  color: MyThemeData.onBackground,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SizedBox(
                width: width,
              ),
            ),
            SizedBox(
              width: width * 0.01,
            ),
            objconditionIndex == myIndex
                ? Icon(
                    Icons.check,
                    color: MyThemeData.onBackground,
                    size: width * 0.05,
                  )
                : const SizedBox(),
            SizedBox(
              width: width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
