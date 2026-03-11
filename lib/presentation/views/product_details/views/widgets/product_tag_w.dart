import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';

import '../../../../../common/colors/app_colors.dart';
import '../../../../../common/dimensions/spacing.dart';

class ProductTag extends StatelessWidget {
  final ProductEntity product;

  const ProductTag({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        (product.tags != null && product.tags!.isNotEmpty)
            ? Column(
                children: [
                  Text(
                    "Tags",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                          color:
                          AppColors.cF2F2F2,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(tag, style: TextStyle(fontSize: 12.sp)),
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
