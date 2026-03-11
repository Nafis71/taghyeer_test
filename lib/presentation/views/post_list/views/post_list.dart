import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/dimensions/app_padding.dart';
import 'package:taghyeer_test/common/dimensions/spacing.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';
import 'package:taghyeer_test/presentation/view_models/post_vm.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_app_bar_w.dart';
import 'package:taghyeer_test/presentation/views/post_list/widgets/post_list_card_w.dart';

import '../../../../common/assets/svg/svg_asset.dart';
import '../../../../common/colors/app_colors.dart';
import '../../../../common/helpers/post_frame.dart';
import '../../common_widgets/common_empty_view_w.dart';
import '../../common_widgets/pagination_loader_w.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final PostVM _postVM = Get.find();
  final ThemeVM _themeVM = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    PostFrame.executeTask(
      task: () {
        if (_postVM.postList.isNotEmpty) return;
        _postVM.loadPostList();
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
      _postVM.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Posts",
        themeVM: _themeVM,
        icon: SvgAsset.postOutlined,
      ),
      body: SafeArea(
        child: Obx(() {
          if (_postVM.isLoading.value) {
            return Obx(
              () => Center(
                child: CupertinoActivityIndicator.partiallyRevealed(
                  color: _themeVM.isDarkMode(context)
                      ? AppColors.white
                      : AppColors.cPrimary,
                ),
              ),
            );
          }
          if (_postVM.postList.isEmpty) {
            return CommonEmptyView(
              description:
                  "Couldn't find any posts right now, try again later!",
            );
          }
          return ListView.separated(
            padding: REdgeInsets.all(AppPaddings.kDefaultPadding),
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index == _postVM.postList.length) {
                return PaginationLoader(themeVM: _themeVM);
              }
              final PostEntity postEntity = _postVM.postList[index];
              return PostListCard(
                postEntity: postEntity,
                key: ValueKey(postEntity.id),
                themeVM: _themeVM,
              );
            },
            separatorBuilder: (context, index) {
              if (index == _postVM.postList.length - 1 &&
                  _postVM.isLoadingMore.value) {
                return const SizedBox.shrink();
              }
              return Spacing.vertical(12);
            },
            itemCount:
                _postVM.postList.length + (_postVM.isLoadingMore.value ? 1 : 0),
          );
        }),
      ),
    );
  }
}
