import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/colors/app_colors.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: REdgeInsets.all(16.0),
      child: const CupertinoActivityIndicator.partiallyRevealed(
        color: AppColors.cPrimary,
      ),
    );
  }
}
