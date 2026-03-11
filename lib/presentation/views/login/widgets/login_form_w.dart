import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/presentation/view_models/auth_vm.dart';

import '../../../../common/colors/app_colors.dart';
import '../../../../common/dimensions/spacing.dart';
import '../../common_widgets/common_button_w.dart';
import '../../common_widgets/common_text_form_filed_w.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthVM _authVM = Get.find();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text("Username", style: Theme.of(context).textTheme.bodyLarge),
        Spacing.vertical(8),
        CommonTextField(
          controller: _userNameController,
          hint: "Type your username",
          maxLines: 1,
          keyboardType: .emailAddress,
        ),
        Spacing.vertical(16),
        Text("Password", style: Theme.of(context).textTheme.bodyLarge),
        Spacing.vertical(8),
        CommonTextField(
          controller: _passwordController,
          hint: "Type your password",
          isPassword: true,
          isSecure: true,
          maxLines: 1,
          keyboardType: .visiblePassword,
        ),
        Spacing.vertical(32),
        Obx(
          () => CommonButton(
            isRoundedButton: false,
            isBorderedButton: true,
            title: "Login",
            titleColor: AppColors.white,
            backgroundColor: AppColors.cPrimary,
            borderColor: AppColors.cTransparent,
            showLoading: _authVM.isBusy.value,
            callbackFunction: () {
              _authVM.initiateUserLogin(
                _userNameController.text,
                _passwordController.text,
              );
            },
          ),
        ),
      ],
    );
  }
}
