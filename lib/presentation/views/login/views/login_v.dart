import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/common/dimensions/app_padding.dart';
import 'package:taghyeer_test/presentation/views/login/widgets/login_form_w.dart';
import 'package:taghyeer_test/presentation/views/login/widgets/login_header_w.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RPadding(
            padding: REdgeInsets.all(AppPaddings.kDefaultPadding),
            child: Column(
              spacing: 16.h,
              children: [LoginHeader(), LoginForm()],
            ),
          ),
        ),
      ),
    );
  }
}
