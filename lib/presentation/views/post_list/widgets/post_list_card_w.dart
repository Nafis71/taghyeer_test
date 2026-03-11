/// Card widget for displaying post items in a list.
///
/// This widget displays a post card with title, truncated body content,
/// tags, and reaction counts (likes/dislikes). Tapping the card navigates
/// to the post details screen.
///
/// Features:
/// - Post title and truncated body
/// - Tag chips display
/// - Like and dislike counts with icons
/// - Theme-aware styling
/// - Navigation to post details
///
/// Example:
/// ```dart
/// PostListCard(
///   postEntity: postEntity,
///   themeVM: themeVM,
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';

import '../../../../common/assets/svg/svg_asset.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/dimensions/app_padding.dart';
import '../../../../common/dimensions/spacing.dart';
import '../../common_widgets/svg_picture_w.dart';

class PostListCard extends StatelessWidget {
  /// Post entity to display.
  final PostEntity postEntity;

  /// Theme view model for theme-aware styling.
  final ThemeVM themeVM;

  /// Creates a new [PostListCard] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [postEntity]: Post entity to display
  /// - [themeVM]: Theme view model for styling
  const PostListCard({
    super.key,
    required this.postEntity,
    required this.themeVM,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.postDetails, arguments: {
          "post": postEntity,
        });
      },
      child: Container(
      padding: REdgeInsets.all(AppPaddings.kDefaultPadding),
      decoration: BoxDecoration(
        color: context.theme.cardTheme.color,
        borderRadius: .circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            postEntity.title ?? "",
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontSize: 19.sp),
          ),
          Spacing.vertical(8),
          Text(
            maxLines: 3,
            overflow: .ellipsis,
            postEntity.body ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(),
          ),
          Spacing.vertical(12),
          Wrap(
            spacing: 8.w,
            children: List.generate(postEntity.tags?.length ?? 0, (index) {
              final String tag = postEntity.tags?[index] ?? "";
              return Container(
                padding: REdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: AppPaddings.kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cF2F2F2,
                  borderRadius: .circular(30.r),
                ),
                child: Text(
                  "#${tag.capitalizeFirst ?? ''}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.cPrimary.withValues(alpha: 0.5),
                  ),
                ),
              );
            }),
          ),
          Spacing.vertical(16),
          Obx(
            () => Row(
              spacing: 12.w,
              children: [
                Row(
                  spacing: 4.w,
                  children: [
                    SvgPictureWidget(
                      assetPath: SvgAsset.like,
                      width: 24.w,
                      height: 24.h,
                      color: themeVM.isDarkMode(context) ? Colors.white : null,
                    ),
                    Text(
                      postEntity.reactions?.likes.toString() ?? "0",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 4.w,
                  children: [
                    SvgPictureWidget(
                      assetPath: SvgAsset.dislike,
                      width: 24.w,
                      height: 24.h,
                      color: themeVM.isDarkMode(context) ? Colors.white : null,
                    ),
                    Text(
                      postEntity.reactions?.likes.toString() ?? "0",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
