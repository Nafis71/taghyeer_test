import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';
import 'package:taghyeer_test/presentation/views/post_list/views/post_list.dart';
import 'package:taghyeer_test/presentation/views/product_list/views/product_list_v.dart';
import 'package:taghyeer_test/presentation/views/settings/views/settings_v.dart';

import '../../../common/assets/svg/svg_asset.dart';
import '../../../common/colors/app_colors.dart';
import '../../view_models/bottom_navigation_vm.dart';
import '../common_widgets/svg_picture_w.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final BottomNavigationVM _bottomNavigationVM = Get.find();
  final ThemeVM _themeVM = Get.find();

  /// List of all main screens accessible via bottom navigation.
  List<Widget> screens = [ProductList(), PostList(), Settings()];

  /// Outlined icon paths for inactive navigation tabs.
  List<String> outlinedIcons = [
    SvgAsset.productOutlined,
    SvgAsset.postOutlined,
    SvgAsset.settingsOutlined,
  ];

  /// Filled icon paths for active navigation tabs.
  List<String> filledIcons = [
    SvgAsset.productFilled,
    SvgAsset.postFilled,
    SvgAsset.settingsFilled,
  ];

  /// Display names for each navigation tab.
  List<String> screenNames = ["Product", "Post", "Settings"];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screens[_bottomNavigationVM.currentIndex],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: _bottomNavigationVM.currentIndex,
            useLegacyColorScheme: false,
            onTap: (index) {
              _bottomNavigationVM.setCurrentIndex = index;
            },
            items: List.generate(screens.length, (index) {
              return _getNavigationBarItem(index);
            }),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _getNavigationBarItem(int index) {
    return BottomNavigationBarItem(
      icon: RPadding(
        padding: .only(top: 8.r,bottom: 3.r),
        child: SvgPictureWidget(
          assetPath: outlinedIcons[index],
          width: 24.w,
          height: 24.h,
          color: _bottomNavigationVM.currentIndex == index
              ? AppColors.black
              : Colors.grey.shade600,
        ),
      ),
      label: screenNames[index],
      activeIcon: Obx(()=>RPadding(
        padding: .only(top: 8.r,bottom: 3.r),
        child: SvgPictureWidget(
          width: 24.w,
          height: 24.h,
          assetPath: filledIcons[index],
          color: _themeVM.isDarkMode(context) ? AppColors.white : null,
        ),
      )),
    );
  }
}
