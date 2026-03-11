import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/themes/app_theme.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';

import 'common/utils/di/dependency_injection.dart';
import 'common/utils/routing/app_routes.dart';
import 'data/local/controller/storage_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initApp();
  runApp(
    /// Initialize ScreenUtil for responsive design.
    /// Design size matches iPhone X dimensions (375x812).
    ScreenUtilInit(
      designSize: (const Size(375, 812)),
      minTextAdapt: true,
      splitScreenMode: true,
      child: TaghyeerTest(),
    ),
  );
}

Future<void> _initApp()async {
  await StorageController().init();
  await NetworkController().init();
  DependencyInjection.init();
}

class TaghyeerTest extends StatelessWidget {
  const TaghyeerTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: .noScaling),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        initialRoute: AppPages.initial,
        getPages: AppRoutes.appRoutes,
        theme: AppTheme.getLightTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
