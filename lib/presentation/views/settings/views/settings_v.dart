import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/dimensions/app_padding.dart';
import 'package:taghyeer_test/common/dimensions/spacing.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';
import 'package:taghyeer_test/presentation/view_models/user_vm.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_app_bar_w.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/svg_picture_w.dart';

import '../../../../common/assets/svg/svg_asset.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final UserVM _userVM = Get.find();
  final ThemeVM _themeVM = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Settings",
        themeVM: _themeVM,
        icon: SvgAsset.settingsOutlined,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RPadding(
            padding: REdgeInsets.all(AppPaddings.kDefaultPadding),
            child: Column(
              children: [
                Container(
                  padding: REdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: AppPaddings.kDefaultPadding,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.cardTheme.color,
                    borderRadius: .circular(16.r),
                  ),
                  child: Row(
                    spacing: 12.w,
                    children: [
                      Container(
                        width: 78.w,
                        height: 78.h,
                        decoration: BoxDecoration(
                          shape: .circle,
                          image: DecorationImage(
                            image: NetworkImage(_userVM.userInfo?.image ?? ""),
                            fit: .cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 4.h,
                          children: [
                            Row(
                              spacing: 2.w,
                              children: [
                                Text(
                                  _userVM.userInfo?.firstName ?? "",
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  _userVM.userInfo?.lastName ?? "",
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              "(${_userVM.userInfo?.gender?.capitalizeFirst ?? ""})",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.grey.shade700,
                                    fontSize: 13.sp,
                                  ),
                            ),
                            Text(
                              _userVM.userInfo?.email ?? "",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Colors.grey.shade700,
                                    fontSize: 13.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.vertical(16),
                Container(
                  padding: REdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: AppPaddings.kDefaultPadding,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.cardTheme.color,
                    borderRadius: .circular(16.r),
                  ),
                  child: Column(
                    spacing: 22.h,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "Dark mode",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
                          ),
                          Obx(
                            () => Switch(
                              value: _themeVM.isDarkMode(context),
                              onChanged: (value) {
                                _themeVM.setThemeMode = value
                                    ? ThemeMode.dark
                                    : ThemeMode.light;
                              },
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        behavior: .opaque,
                        onTap: (){
                          _userVM.logoutUser();
                        },
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              "Logout",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
                            ),
                            Obx(
                              () => SvgPictureWidget(
                                assetPath: SvgAsset.rightArrow,
                                width: 18.w,
                                height: 18.h,
                                color: _themeVM.isDarkMode(context)
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
