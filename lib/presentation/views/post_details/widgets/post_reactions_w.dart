/// Widget for displaying post reactions (likes and dislikes).
///
/// This widget displays the number of likes and dislikes for a post
/// with corresponding icons. The icons adapt their color based on
/// the current theme (light/dark mode).
///
/// Features:
/// - Like count with icon
/// - Dislike count with icon
/// - Theme-aware icon coloring
/// - Reactive updates using GetX
///
/// Example:
/// ```dart
/// PostReactions(post: postEntity)
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';

import '../../../../common/assets/svg/svg_asset.dart';
import '../../../../common/dimensions/spacing.dart';
import '../../common_widgets/svg_picture_w.dart';

class PostReactions extends StatelessWidget {
  /// Post entity containing reactions to display.
  final PostEntity post;

  /// Optional theme view model (falls back to Get.find if not provided).
  final ThemeVM? themeVM;

  /// Creates a new [PostReactions] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [post]: Post entity with reactions
  /// - [themeVM]: Optional theme view model
  const PostReactions({
    super.key,
    required this.post,
    this.themeVM,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeVM vm = themeVM ?? Get.find<ThemeVM>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reactions",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Spacing.vertical(8),
        Row(
          spacing: 24.w,
          children: [
            // Likes
            Row(
              spacing: 8.w,
              children: [
                Obx(
                  () => SvgPictureWidget(
                    assetPath: SvgAsset.like,
                    width: 24.w,
                    height: 24.h,
                    color: vm.isDarkMode(context) ? Colors.white : null,
                  ),
                ),
                Text(
                  "${post.reactions?.likes ?? 0}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Likes",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),

            // Dislikes
            Row(
              spacing: 8.w,
              children: [
                Obx(
                  () => SvgPictureWidget(
                    assetPath: SvgAsset.dislike,
                    width: 24.w,
                    height: 24.h,
                    color: vm.isDarkMode(context) ? Colors.white : null,
                  ),
                ),
                Text(
                  "${post.reactions?.dislikes ?? 0}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Dislikes",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
