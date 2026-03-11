/// Widget for displaying empty state views.
///
/// This widget displays an empty state message with an icon and optional
/// description text. It's commonly used when lists are empty or when
/// no data is available to display.
///
/// Features:
/// - Centered layout
/// - Empty result SVG icon
/// - Optional description text
/// - Theme-aware styling
///
/// Example:
/// ```dart
/// CommonEmptyView(
///   description: "No products found",
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/assets/svg/svg_asset.dart';
import 'package:taghyeer_test/common/dimensions/app_padding.dart';
import 'package:taghyeer_test/common/dimensions/spacing.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/svg_picture_w.dart';

class CommonEmptyView extends StatefulWidget {
  /// Optional description text displayed below the icon.
  final String? description;

  /// Creates a new [CommonEmptyView] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [description]: Optional description text
  const CommonEmptyView({super.key, this.description});

  @override
  State<CommonEmptyView> createState() => _CommonEmptyViewState();
}

class _CommonEmptyViewState extends State<CommonEmptyView> {
  final ThemeVM _themeVM = Get.find();

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: REdgeInsets.symmetric(horizontal: AppPaddings.kDefaultPadding),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          Center(
            child: SvgPictureWidget(
              assetPath: SvgAsset.emptyResult,
              width: 180.w,
              height: 180.h,
              applyColor: false,
            ),
          ),
          Spacing.vertical(12),
          Text(widget.description ?? "",textAlign: .center,),
        ],
      ),
    );
  }
}
