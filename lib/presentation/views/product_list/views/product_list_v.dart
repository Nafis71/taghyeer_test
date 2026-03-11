/// Product list screen displaying products in a grid layout.
///
/// This screen shows a paginated grid of products with the following features:
/// - Grid layout (2 columns)
/// - Infinite scroll pagination
/// - Loading states (initial load and pagination)
/// - Empty state handling
/// - Scroll detection for automatic pagination
///
/// The screen automatically loads products when scrolled to 80% of the list
/// and displays a loader at the end when fetching more items.
///
/// Navigation:
/// - Tapping a product card navigates to product details screen
///
/// State Management:
/// - Uses [ProductVM] for product data and pagination state
/// - Uses [ThemeVM] for theme management
/// - Reactive UI updates using GetX observables
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
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_app_bar_w.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_empty_view_w.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/pagination_loader_w.dart';

import '../widgets/product_list_card_w.dart';

/// Product list screen widget.
///
/// Displays products in a grid layout with pagination support.
class ProductList extends StatefulWidget {
  /// Creates a new [ProductList] instance.
  ///
  /// Parameters:
  /// - [key]: Optional widget key for identification
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

/// State class for [ProductList] widget.
///
/// Manages scroll controller, view models, and pagination logic.
class _ProductListState extends State<ProductList> {
  /// Product view model instance for managing product data.
  ///
  /// Retrieved from GetX dependency injection container.
  final ProductVM _productVM = Get.find();

  /// Theme view model instance for theme management.
  ///
  /// Used for theme-aware UI components.
  final ThemeVM _themeVM = Get.find();

  /// Scroll controller for detecting scroll position.
  ///
  /// Used to trigger pagination when user scrolls near the end of the list.
  final ScrollController _scrollController = ScrollController();

  /// Initializes the product list screen.
  ///
  /// Performs the following setup:
  /// 1. Loads products if the list is empty (prevents reloading on navigation back)
  /// 2. Sets up scroll listener for pagination detection
  ///
  /// Uses [PostFrame.executeTask] to ensure the frame is built before
  /// making API calls, preventing potential layout issues.
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

  /// Cleans up resources when the widget is disposed.
  ///
  /// Removes scroll listener and disposes the scroll controller
  /// to prevent memory leaks.
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Handles scroll events to trigger pagination.
  ///
  /// When the user scrolls to 80% of the list, automatically triggers
  /// loading more products. This provides a smooth infinite scroll experience.
  ///
  /// The 80% threshold ensures products are loaded before the user
  /// reaches the end, reducing perceived loading time.
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
      appBar: CommonAppBar(
        title: "Products",
        themeVM: _themeVM,
        icon: SvgAsset.productOutlined,
      ),
      body: SafeArea(
        child: Obx(() {
          if (_productVM.isLoading.value) {
            return Obx(
                  () => Center(
                child: CupertinoActivityIndicator.partiallyRevealed(
                  color: _themeVM.isDarkMode(context) ? AppColors.white : AppColors.cPrimary,
                ),
              ),
            );
          }
          if (_productVM.productList.isEmpty) {
            return CommonEmptyView(
              description: "Couldn't find any product information right now, try again later!",
            );
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
              if (_productVM.isLoadingMore.value) PaginationLoader(
                themeVM: _themeVM,
              ),
            ],
          );
        }),
      ),
    );
  }
}
