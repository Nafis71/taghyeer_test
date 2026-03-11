import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/assets/png/png_asset.dart';
import 'package:taghyeer_test/common/helpers/post_frame.dart';
import 'package:taghyeer_test/presentation/view_models/splash_vm.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashVM _splashVM = Get.find();

  @override
  void initState() {
    PostFrame.executeTask(task: _splashVM.triggerSplash);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Image.asset(PngAsset.appLogo, width: 180.w, height: 180.h),
      ),
    );
  }
}
