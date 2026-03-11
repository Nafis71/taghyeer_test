/// A reusable loading indicator widget for pagination.
///
/// This widget displays a loading spinner that appears at the end of scrollable
/// lists when more items are being loaded. It automatically adapts its color
/// based on the current theme (light/dark mode).
///
/// Features:
/// - Theme-aware color adaptation
/// - Responsive padding using ScreenUtil
/// - Reactive updates using GetX observables
/// - Consistent styling across the app
///
/// Usage:
/// ```dart
/// if (viewModel.isLoadingMore.value)
///   PaginationLoader(themeVM: themeVM)
/// ```
///
/// The widget should be placed at the end of a list view to indicate
/// that more content is being loaded.
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';

import '../../../common/colors/app_colors.dart';

class PaginationLoader extends StatelessWidget {
  /// Theme view model instance for determining current theme.
  ///
  /// Used to adapt the loader color based on light/dark mode.
  final ThemeVM themeVM;

  /// Creates a new [PaginationLoader] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key for identification
  /// - [themeVM]: Theme view model for color adaptation
  const PaginationLoader({super.key, required this.themeVM});

  /// Builds the pagination loader widget.
  ///
  /// Returns a [Widget] containing:
  /// - Responsive padding (16.0 on all sides)
  /// - Cupertino activity indicator
  /// - Theme-aware color (white for dark mode, primary for light mode)
  ///
  /// The widget uses [Obx] to reactively update when theme changes.
  ///
  /// Returns a [Widget] representing the loading indicator.
  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: REdgeInsets.all(16.0),
      child: Obx(
        () => CupertinoActivityIndicator.partiallyRevealed(
          color: themeVM.isDarkMode(context)
              ? AppColors.white
              : AppColors.cPrimary,
        ),
      ),
    );
  }
}
