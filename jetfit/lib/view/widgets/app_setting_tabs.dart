import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';

class PotraitWidgetSettingTabs extends StatelessWidget {
  const PotraitWidgetSettingTabs({
    super.key,
    required this.height,
    required this.myIndex,
    required this.objindex,
    required this.text,
    required this.value0,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.textconditionIndex,
    required this.width,
  });

  final double height;
  final int objindex;
  final String text;
  final String value0;
  final String value1;
  final String value2;
  final String value3;
  final String value4;
  final String value5;
  final int textconditionIndex;
  final int myIndex;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.075,
      width: width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: objindex == myIndex
              ? MyThemeData.onBackground
              : MyThemeData.onBackground.withOpacity(0.4)),
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
                  color: objindex == myIndex
                      ? MyThemeData.background
                      : MyThemeData.onBackground,
                  fontSize: width * 0.037,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    textconditionIndex == 0
                        ? value0
                        : textconditionIndex == 1
                            ? value1
                            : textconditionIndex == 2
                                ? value2
                                : textconditionIndex == 3
                                    ? value3
                                    : textconditionIndex == 4
                                        ? value4
                                        : textconditionIndex == 5
                                            ? value5
                                            : '',
                    style: TextStyle(
                      color: objindex == myIndex
                          ? MyThemeData.background
                          : MyThemeData.onBackground,
                      fontSize: width * 0.035,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color:
                  objindex == myIndex ? Colors.green : MyThemeData.onBackground,
              size: width * 0.05,
            ),
            SizedBox(
              width: width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
