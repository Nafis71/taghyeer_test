import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/dimensions/spacing.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';
import 'package:taghyeer_test/presentation/view_models/product_vm.dart';
import 'package:taghyeer_test/presentation/views/product_details/widgets/product_image_carousel_w.dart';
import 'package:taghyeer_test/presentation/views/product_details/widgets/product_information_w.dart';

class ProductDetails extends StatefulWidget {

  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController _pageController = PageController();
  final ProductVM _productVM = Get.find();
  late final Map<String,dynamic>? _arguments;
  late final ProductEntity? _product;

  @override
  void initState() {
    _arguments = Get.arguments;
    _product = _arguments?['product'];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _productVM.productDetailsImageCurrentIndex.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_product == null) throw "_product is null";
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_product.images?.isNotEmpty ?? false) ...[
                ProductImageCarousel(
                  pageController: _pageController,
                  images: _product.images ?? [],
                  productVM: _productVM,
                ),
                Spacing.vertical(16),
              ],
              ProductInformation(product: _product),
            ],
          ),
        ),
      ),
    );
  }
}
