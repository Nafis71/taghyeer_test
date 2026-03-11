import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/presentation/views/product_details/views/widgets/additional_information_w.dart';
import 'package:taghyeer_test/presentation/views/product_details/views/widgets/product_extra_details_w.dart';
import 'package:taghyeer_test/presentation/views/product_details/views/widgets/product_tag_w.dart';

import '../../../../../common/dimensions/app_padding.dart';
import '../../../../../common/dimensions/spacing.dart';
import '../../../../../domain/entities/product_entity_e.dart';

class ProductInformation extends StatelessWidget {
  final ProductEntity product;

  const ProductInformation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        RPadding(
          padding: REdgeInsets.symmetric(
            horizontal: AppPaddings.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                product.title ?? "No Title",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacing.vertical(8),

              // Price and Discount
              Row(
                children: [
                  Text(
                    "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (product.discountPercentage != null &&
                      product.discountPercentage! > 0) ...[
                    Spacing.horizontal(12),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "${product.discountPercentage!.toStringAsFixed(0)}% OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Spacing.vertical(12),

              // Rating and Stock
              Row(
                children: [
                  if (product.rating != null) ...[
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20.sp),
                        Spacing.horizontal(4),
                        Text(
                          product.rating!.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Spacing.horizontal(16),
                  ],
                  if (product.stock != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: product.stock! > 0
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        product.stock! > 0
                            ? "In Stock (${product.stock})"
                            : "Out of Stock",
                        style: TextStyle(
                          color: product.stock! > 0 ? Colors.green : Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Spacing.vertical(16),

              // Description
              if (product.description != null &&
                  product.description!.isNotEmpty) ...[
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacing.vertical(8),
                Text(
                  product.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Spacing.vertical(16),
              ],

              // Product Details Section
              ProductExtraDetails(product: product),
              Spacing.vertical(16),

              // Tags
              ProductTag(product: product),

              // Additional Information
              AdditionalInformation(product: product),
            ],
          ),
        ),
      ],
    );
  }
}
