/// Widget for displaying product extra details (brand, category, SKU, weight).
///
/// This widget displays key product information in a label-value format.
/// Each detail is shown as a row with a label on the left and value on the right.
/// Only non-empty values are displayed.
///
/// Example:
/// ```dart
/// ProductExtraDetails(product: productEntity)
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';

import '../../../../common/dimensions/spacing.dart';

class ProductExtraDetails extends StatelessWidget {
  /// Product entity containing details to display.
  final ProductEntity product;

  /// Creates a new [ProductExtraDetails] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [product]: Product entity with details
  const ProductExtraDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Product Details",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Spacing.vertical(8),
        _buildDetailRow("Brand", product.brand, context),
        _buildDetailRow("Category", product.category, context),
        _buildDetailRow("SKU", product.sku, context),
        if (product.weight != null)
          _buildDetailRow("Weight", "${product.weight} g", context),
      ],
    );
  }

  Widget _buildDetailRow(String label, String? value, BuildContext context) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              "$label:",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
