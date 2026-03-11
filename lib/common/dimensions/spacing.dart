import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Utility class providing consistent vertical and horizontal spacing across the app.
///
/// Uses ScreenUtil for responsive spacing that adapts to different screen sizes.
/// All spacing values are automatically scaled based on the device's screen dimensions.
class Spacing {
  /// Creates a vertical spacing widget with the specified height.
  ///
  /// The spacing is responsive and scales based on screen size using ScreenUtil.
  ///
  /// [space] - The height of the vertical spacing in logical pixels.
  /// Returns a [SizedBox] widget with the specified vertical spacing.
  static Widget vertical(double space) => space.verticalSpace;

  /// Creates a horizontal spacing widget with the specified width.
  ///
  /// The spacing is responsive and scales based on screen size using ScreenUtil.
  ///
  /// [space] - The width of the horizontal spacing in logical pixels.
  /// Returns a [SizedBox] widget with the specified horizontal spacing.
  static Widget horizontal(double space) => space.horizontalSpace;
}
