/// Widget for displaying additional product information.
///
/// This widget displays supplementary product details including:
/// - Availability status
/// - Shipping information
/// - Return policy
/// - Warranty information
/// - Minimum order quantity
///
/// Only displays if at least one of these fields is available.
///
/// Example:
/// ```dart
/// AdditionalInformation(product: productEntity)
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';

import '../../../../common/dimensions/spacing.dart';

class AdditionalInformation extends StatelessWidget {
  /// Product entity containing additional information.
  final ProductEntity product;

  /// Creates a new [AdditionalInformation] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [product]: Product entity with additional information
  const AdditionalInformation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return (product.warrantyInformation != null ||
            product.shippingInformation != null ||
            product.returnPolicy != null ||
            product.availabilityStatus != null)
        ? Column(
            children: [
              Text(
                "Additional Information",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Spacing.vertical(8),
              if (product.availabilityStatus != null)
                _buildDetailRow(
                  "Availability",
                  product.availabilityStatus,
                  context,
                ),
              if (product.shippingInformation != null)
                _buildDetailRow(
                  "Shipping",
                  product.shippingInformation,
                  context,
                ),
              if (product.returnPolicy != null)
                _buildDetailRow("Return Policy", product.returnPolicy, context),
              if (product.warrantyInformation != null)
                _buildDetailRow(
                  "Warranty",
                  product.warrantyInformation,
                  context,
                ),
              if (product.minimumOrderQuantity != null)
                _buildDetailRow(
                  "Minimum Order",
                  "${product.minimumOrderQuantity} units",
                  context,
                ),
              Spacing.vertical(16),
            ],
          )
        : SizedBox.shrink();
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
