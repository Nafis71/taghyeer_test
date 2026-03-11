/// Image carousel widget for displaying product images.
///
/// This widget displays a swipeable image carousel with page indicators.
/// Users can swipe horizontally to view different product images.
/// The current page index is tracked and displayed as dots at the bottom.
///
/// Features:
/// - Horizontal swipeable PageView
/// - Page indicator dots
/// - Network image loading with error handling
/// - Reactive page index tracking
///
/// Example:
/// ```dart
/// ProductImageCarousel(
///   pageController: pageController,
///   images: product.images,
///   productVM: productVM,
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/logger/logger_util.dart';
import 'package:taghyeer_test/presentation/view_models/product_vm.dart';

import '../../../../common/colors/app_colors.dart';

class ProductImageCarousel extends StatelessWidget {
  /// Page controller for managing carousel navigation.
  final PageController pageController;

  /// List of image URLs to display.
  final List<String> images;

  /// Product view model for tracking current page index.
  final ProductVM productVM;

  /// Creates a new [ProductImageCarousel] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key
  /// - [pageController]: Page controller for carousel
  /// - [images]: List of image URLs
  /// - [productVM]: Product view model for state management
  const ProductImageCarousel({
    super.key,
    required this.pageController,
    required this.images,
    required this.productVM,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              productVM.productDetailsImageCurrentIndex.value = index;
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cF2F2F2,
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      logger.e(exception,stackTrace: stackTrace);
                    },
                  ),
                ),
              );
            },
          ),
          if (images.length > 1)
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Obx(()=>Container(
                    width: 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      productVM.productDetailsImageCurrentIndex.value ==
                          index
                          ? AppColors.black
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                  ),),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
