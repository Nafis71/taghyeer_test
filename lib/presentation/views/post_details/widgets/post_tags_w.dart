/// Widget for displaying post tags as chips.
///
/// This widget displays post tags in a horizontal wrap layout.
/// Tags are displayed as rounded chips with "#" prefix and capitalized text.
/// If no tags are available, the widget returns an empty SizedBox.
///
/// Example:
/// ```dart
/// PostTags(post: postEntity)
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';

import '../../../../common/dimensions/spacing.dart';

class PostTags extends StatelessWidget {
  /// Post entity containing tags to display.
  final PostEntity post;

  /// Creates a new [PostTags] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [post]: Post entity with tags
  const PostTags({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return (post.tags != null && post.tags!.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tags",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Spacing.vertical(8),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: post.tags!.map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      "#${tag.capitalizeFirst ?? ""}",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                }).toList(),
              ),
              Spacing.vertical(16),
            ],
          )
        : const SizedBox.shrink();
  }
}
