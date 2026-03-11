/// Reusable app bar widget with icon and title.
///
/// This widget provides a consistent app bar design across the application
/// with a leading icon and title. The icon color adapts to the current theme
/// (light/dark mode).
///
/// Features:
/// - Theme-aware icon coloring
/// - Responsive sizing using ScreenUtil
/// - Reactive updates using GetX observables
/// - Consistent styling across screens
///
/// Example:
/// ```dart
/// CommonAppBar(
///   title: "Products",
///   themeVM: themeVM,
///   icon: SvgAsset.productFilled,
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/svg_picture_w.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// App bar title text.
  final String title;

  /// Theme view model for determining current theme.
  final ThemeVM themeVM;

  /// Path to the SVG icon asset.
  final String icon;

  /// Creates a new [CommonAppBar] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [title]: App bar title text
  /// - [themeVM]: Theme view model for color adaptation
  /// - [icon]: SVG asset path for the leading icon
  const CommonAppBar({
    super.key,
    required this.title,
    required this.themeVM,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        spacing: 12.w,
        children: [
          Obx(
            () => SvgPictureWidget(
              assetPath: icon,
              width: 24.w,
              height: 24.h,
              color: themeVM.isDarkMode(context) ? Colors.white : null,
            ),
          ),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
