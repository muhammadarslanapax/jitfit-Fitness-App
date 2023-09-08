import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/web_view/auth/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: MyThemeData.tertiary20),
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: Responsive.isMobile(context)
                  ? 1
                  : Responsive.isTablet(context)
                      ? 1
                      : 8,
              child: SvgPicture.asset("images/icons/signup.svg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
