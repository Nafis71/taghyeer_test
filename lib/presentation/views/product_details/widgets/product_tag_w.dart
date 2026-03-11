/// Widget for displaying product tags as chips.
///
/// This widget displays product tags in a horizontal wrap layout.
/// Tags are displayed as rounded chips with capitalized text.
/// If no tags are available, the widget returns an empty SizedBox.
///
/// Example:
/// ```dart
/// ProductTag(product: productEntity)
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';

import '../../../../common/colors/app_colors.dart';
import '../../../../common/dimensions/spacing.dart';

class ProductTag extends StatelessWidget {
  /// Product entity containing tags to display.
  final ProductEntity product;

  /// Creates a new [ProductTag] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [product]: Product entity with tags
  const ProductTag({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        (product.tags != null && product.tags!.isNotEmpty)
            ? Column(
                crossAxisAlignment: .start,
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
                    children: product.tags!.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(tag.capitalizeFirst ?? "", style: TextStyle(fontSize: 12.sp)),
                      );
                    }).toList(),
                  ),
                  Spacing.vertical(16),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
