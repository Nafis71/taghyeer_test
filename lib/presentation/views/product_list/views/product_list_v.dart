import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/assets/svg/svg_asset.dart';
import 'package:taghyeer_test/common/colors/app_colors.dart';
import 'package:taghyeer_test/common/dimensions/app_padding.dart';
import 'package:taghyeer_test/common/helpers/post_frame.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';
import 'package:taghyeer_test/presentation/view_models/product_vm.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/pagination_loader_w.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/svg_picture_w.dart';

import '../widgets/product_list_card_w.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductVM _productVM = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    PostFrame.executeTask(
      task: () {
        if (_productVM.productList.isNotEmpty) return;
        _productVM.loadProductList();
      },
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // Load more when user scrolls to 80% of the list
      _productVM.loadMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 12.w,
          children: [
            SvgPictureWidget(
              assetPath: SvgAsset.productOutlined,
              width: 24.w,
              height: 24.h,
            ),
            Text(
              "Product list",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (_productVM.isLoading.value) {
            return const Center(
              child: CupertinoActivityIndicator.partiallyRevealed(
                color: AppColors.cPrimary,
              ),
            );
          }
          if (_productVM.productList.isEmpty) {
            return SizedBox.shrink();
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  padding: REdgeInsets.all(AppPaddings.kDefaultPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    mainAxisExtent: 350,
                  ),
                  itemCount: _productVM.productList.length,
                  itemBuilder: (context, index) {
                    final ProductEntity product = _productVM.productList[index];
                    return ProductListCard(product: product);
                  },
                ),
              ),
              // Show loader at the end when pagination is in progress
              if (_productVM.isLoadingMore.value)
                PaginationLoader()
            ],
          );
        }),
      ),
    );
  }
}
