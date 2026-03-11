import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/assets/png/png_asset.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/dimensions/spacing.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            PngAsset.appLogo,
            width: 180.w,
            height: 180.h,
          ),
        ),
        Spacing.vertical(16),
        Text(
          "Welcome",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 27.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacing.vertical(4),
        RichText(
          textAlign: .center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "By signing in I agree to company's ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: "Privacy Statement",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.cPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " and ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text: "Terms of service",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.cPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
