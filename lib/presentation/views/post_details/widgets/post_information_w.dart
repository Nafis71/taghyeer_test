/// Widget for displaying comprehensive post information.
///
/// This widget displays all post details including title, view count,
/// body content, reactions, and tags. It composes multiple smaller widgets
/// to create a complete post information display.
///
/// Features:
/// - Post title
/// - View count with icon
/// - Post body/content
/// - Reactions (likes/dislikes)
/// - Post tags
///
/// Example:
/// ```dart
/// PostInformation(post: postEntity)
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/presentation/views/post_details/widgets/post_reactions_w.dart';
import 'package:taghyeer_test/presentation/views/post_details/widgets/post_tags_w.dart';

import '../../../../common/dimensions/app_padding.dart';
import '../../../../common/dimensions/spacing.dart';
import '../../../../domain/entities/post_e.dart';

class PostInformation extends StatelessWidget {
  /// Post entity to display information for.
  final PostEntity post;

  /// Creates a new [PostInformation] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [post]: Post entity to display
  const PostInformation({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RPadding(
          padding: REdgeInsets.symmetric(
            horizontal: AppPaddings.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title ?? "No Title",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Spacing.vertical(12),
              if (post.views != null)
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 18.sp,
                      color: Colors.grey[600],
                    ),
                    Spacing.horizontal(6),
                    Text(
                      "${post.views} views",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              Spacing.vertical(16),
              if (post.body != null && post.body!.isNotEmpty) ...[
                Text(
                  "Content",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Spacing.vertical(8),
                Text(
                  post.body!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacing.vertical(16),
              ],
              PostReactions(post: post),
              Spacing.vertical(16),
              PostTags(post: post),
            ],
          ),
        ),
      ],
    );
  }
}
