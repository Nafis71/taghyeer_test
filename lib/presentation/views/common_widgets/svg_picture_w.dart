import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable widget for displaying SVG images from assets.
///
/// Provides a convenient wrapper around [SvgPicture.asset] with
/// customizable sizing, fit mode, and color tinting options.
class SvgPictureWidget extends StatelessWidget {
  /// Path to the SVG asset file.
  final String assetPath;
  
  /// Optional width for the SVG image.
  final double? width;
  
  /// Optional height for the SVG image.
  final double? height;
  
  /// How the SVG should be inscribed into the available space.
  /// Defaults to [BoxFit.contain].
  final BoxFit? fit;
  
  /// Optional color to tint the SVG. Applies color filter
  /// using [BlendMode.srcIn]. Defaults to black if not specified.
  final Color? color;

  /// Whether to apply color tinting to the SVG.
  /// When false, the SVG displays in its original colors.
  /// When true (default), the SVG is tinted with the specified [color].
  final bool applyColor;

  const SvgPictureWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.applyColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: applyColor ? ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn) : null,
    );
  }
}
