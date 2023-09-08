import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/web_view/auth/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "LOGIN",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: MyThemeData.tertiary20),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: Responsive.isMobile(context)
                  ? 3
                  : Responsive.isTablet(context)
                      ? 3
                      : 8,
              child: SvgPicture.asset("images/icons/login.svg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 1),
      ],
    );
  }
}
