import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';

import '../../../../common/assets/svg/svg_asset.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/dimensions/spacing.dart';
import '../../common_widgets/svg_picture_w.dart';
import '../../product_details/views/product_details_v.dart';

class ProductListCard extends StatelessWidget {
  final ProductEntity product;

  const ProductListCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.productDetails,arguments: {
          "product": product,
        });
      },
      child: Column(
        key: ValueKey(product.id),
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cF2F2F2,
                image: DecorationImage(
                  image: NetworkImage(product.thumbnail ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: .topRight,
              child: SvgPictureWidget(
                assetPath: SvgAsset.discount,
                color: Colors.redAccent,
              ),
            ),
          ),
          Spacing.vertical(8),
          Text(
            maxLines: 2,
            overflow: .ellipsis,
            product.title ?? "",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
          ),
          Spacing.vertical(4),
          Text(
            product.description ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            maxLines: 2,
            overflow: .ellipsis,
          ),
          Spacing.vertical(4),
          Text(
            "\$${product.price.toString()}",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: .ellipsis,
          ),
        ],
      ),
    );
  }
}
