import 'package:flutter/material.dart';
import 'package:taghyeer_test/common/colors/app_colors.dart';

class CommonToast {
  static void show({required BuildContext context, required String title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cPrimary,
        content: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
