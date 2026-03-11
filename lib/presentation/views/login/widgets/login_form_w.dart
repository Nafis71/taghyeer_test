import 'package:flutter/material.dart';

import '../../../../common/colors/app_colors.dart';
import '../../../../common/dimensions/spacing.dart';
import '../../common_widgets/common_button_w.dart';
import '../../common_widgets/common_text_form_filed_w.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text("Email", style: Theme.of(context).textTheme.bodyLarge),
        Spacing.vertical(8),
        CommonTextField(
          hint: "Type your email",
          maxLines: 1,
          keyboardType: .emailAddress,
        ),
        Spacing.vertical(16),
        Text("Password", style: Theme.of(context).textTheme.bodyLarge),
        Spacing.vertical(8),
        CommonTextField(
          hint: "Type your password",
          isPassword: true,
          isSecure: true,
          maxLines: 1,
          keyboardType: .visiblePassword,
        ),
        Spacing.vertical(32),
        CommonButton(
          isRoundedButton: false,
          isBorderedButton: true,
          title: "Login",
          titleColor: AppColors.white,
          backgroundColor: AppColors.cPrimary,
          borderColor: AppColors.cTransparent,
        ),
      ],
    );
  }
}
