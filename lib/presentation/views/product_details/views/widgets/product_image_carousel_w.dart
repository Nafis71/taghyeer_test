import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/logger/logger_util.dart';
import 'package:taghyeer_test/presentation/view_models/product_vm.dart';

import '../../../../../common/colors/app_colors.dart';

class ProductImageCarousel extends StatelessWidget {
  final PageController pageController;
  final List<String> images;
  final ProductVM productVM;

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
